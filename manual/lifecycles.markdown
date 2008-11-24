Hobo Lifecycles
{.document-title}

This chapter of the Hobo manual describes Hobo's "lifecycle" mechanism. This is an extension that lets you define a lifecycle for any ActiveRecord model. Defining a lifecycle is like a finite state machine -- a pattern which turns out to be extremely useful for modelling all sorts of processes that crop up in the world that we're trying to model. That might make Hobo's lifecycles sound similar to the well known `acts_as_state_machine` plugin, and in a way they are, but with Hobo style. The big win comes from the fact that, like many things in Hobo, there is support for this feature in all three of the MVC layers, which can make it very quick and easy to get up and running.


Contents
{: .contents-heading}

- contents
{:toc}


# Introduction

In the REST style, which is popular with Rails coders, we view our objects a bit like documents: you can post them to a website, get them again later, make changes to them and delete them. Of course, these objects also have behaviour, which we often implement by hooking functionality to the create / update / delete events (e.g. using callbacks such as `after_create` in ActiveRecord). At a pinch we may have to fall back to the RPC style, which Hobo has support for with the "Web Method" feature.

This works great for many situations, but some objects are *not* best thought of as documents that we create and edit. In particular, applications often contain objects that model some kind of *process*. A good example is *friendship* in a social app. Here's a description of how friendship might work:

 * Any user can **request** friendship with another user
 * The other user can **accept** or **reject** (or perhaps **ignore**) the request.
 * The friendship is only **active** once it's been accepted
 * An active friendship can be **cancelled** by either user.

Not a create, update or delete in sight. Those bold words capture the way we think about the friendship much better. Of course we *could* implement friendship in a RESTful style, but we'd be doing just that -- *implementing* it, not *declaring* it. The life-cycle of the friendship would be hidden in our code, scattered across a bunch of callbacks, permission methods and state variables. Experience has shown this type of code to be tedious to write, *extremely* error prone and fragile when changing.

Hobo lifecycles is a mechanism for declaring the lifecycle of a model in a natural manner.

REST vs. lifecycles is not an either/or choice. Some models will support both styles. A good example is a content management system with some kind of editorial workflow. An application like that might have an Article model, which can be created, updated and deleted like any other REST resource. The Article might also feature a lifecycle that defines how the article goes from newly authored, through one or more stages of review (possibly being rejected at any stage) before finally becoming accepted, and later published.


# An Example

Everyone loves an example, so here is one. We'll stick with the friendship idea. If you want to try this out, create a blank app and add a model:

    $ hobo friends
    $ cd friends
    $ ./script/generate hobo_model friendship
    
Here's the code for the friendship mode (don't be put off by the `MagicMailer`, that's just a made-up class to illustrate a common use of the callback actions -- sending emails):

    class Friendship < ActiveRecord::Base

      hobo_model

      # The 'sender' of the request
      belongs_to :requester, :class_name => "User"

      # The 'recipient' of the request
      belongs_to :requestee, :class_name => "User"

      lifecycle do

        state :requested, :active, :ignored

        create :request, :params => [ :requestee ], :become => :requested,
                         :available_to => "User",
                         :user_becomes => :requester do
          MagicMailer.send requestee, "#{requester.name} wants to be friends with you"
        end

        transition :accept, { :requested => :active }, :available_to => :requestee do
          MagicMailer.send requester, "#{requestee.name} is now your friend :-)"
        end

        transition :reject, { :requested => :destroy }, :available_to => :requestee do
          MagicMailer.send requester, "#{requestee.name} blew you out :-("
        end

        transition :ignore, { :requested => :ignored }, :available_to => :requestee

        transition :retract, { :requested => :destroy }, :available_to => :requester do
          MagicMailer.send requestee, "#{requester.name} reconsidered"
        end

        transition :cancel, { :active => :destroy }, :available_to => [ :requester, :requestee ] do
          to = acting_user == requester ? requestee : requester
          MagicMailer.send to, "#{acting_user.name} cancelled your friendship"
        end

      end

    end
{.ruby}

Visually, the lifecycle can be represented as a graph, just as we would draw a finite state machine:

![Friendship Lifecycle]()/images/manual/friendship-lifecycle.png)

Let's work through what we did there.

Because `Friendship` has a lifecycle declared, a class is created that captures the lifecycle. The class is `Friendship::Lifecycle`. Each instance of `Friendship` will have an instance of this class associated with it, available as `my_friendship.lifecycle`.

The `Friendship` model will also have a field called `state` declared. The migration generator will create a database column for `state`.

The lifecycle has three states:

    state :requested, :active, :ignored
{.ruby}

There is one 'creator' -- this is a starting point for the lifecycle:

    create :request, :params => [ :requestee ], :become => :requested,
                     :available_to => "User",
                     :user_becomes => :requester do
       MagicMailer.send requestee, "#{requester.name} wants to be friends with you"
     end
{.ruby}

That declaration specifies that:

 - The name of the creator is `request`. It will be available as a method `Friendship::Lifecycle.request(user, attributes)`. Calling the method will instantiate the record, setting attributes from the hash that is passed in
 
 - The `:params` option specifies which attributes can be set by this create step:
 
        :params => [ :requestee ]
{.ruby}
 
   any other key in the `attributes` hash passed to `request` will be ignored.
 
 - The lifecycle state after this create step will be `requested`:

        :become => :requested,
{.ruby}
        
 - To have access to this create step, the acting user must be an instance of `User` (i.e. not a guest):
 
        :available_to => "User"
{.ruby}
        
 - After the create step, the `requester` association of the `Friendship` will be set to the acting user:
 
       :user_becomes => :requester
{.ruby}
       
 - After the create step has completed (and the database updated), the block is executed:

        do
          MagicMailer.send requestee, "#{requester.name} wants to be friends with you"
        end
{.ruby}

There are five transitions declared: accept, reject, ignore, retract, cancel. These become methods on the lifecycle object (not the
lifecycle class), e.g. `my_fiendship.lifecycle.accept!(user, attributes)`. Calling that method will:

 - Check if the transition is allowed
 
 - If it is, update the record with the passed in attributes. The attributes that can change are declared in a `:params` option, as we saw
   with the creator. None of the friendship transitions declare any `:params`, so no attributes will change, and
   
 - change the `state` field to the new state, then
 
 - save the record, as long as validations pass.
 
Each transition declares:

 - which states it goes from and to, e.g. `accept` goes from `requested` to `active`:

        transition :accept, { :requested => :active }
        
   Some of the transitions are to a pseudo state: `:destroy`. To move to this state is to destroy the record.
    
 - who has access to it. 
 
        :available_to => :requester
        :available_to => :requestee
        
   In the create step the `:available_to` option was set to a class name, here it is set to a method (a `belongs_to` association) and to be
   allowed, the acting user must be the same user returned by this method. There are a variety ways that `:avilable_to` can be used, which
   will be discussed in detail later.
   
 - a callback (the block). This is called after the transition completes. Notice that in the block for the `cancel`
   transition we're accessing `acting_user`, which is a reference to the user performing the transition.
   
Hopefully that worked example has clarified what lifecycles are all about. We'll move on and look at the details now.


# Key concepts

Before getting into the API we'll recap some of the key concepts very briefly.

As mentioned in the introduction, the lifecycle is essentially a finite state machine. It consists of:

 - One or more *states*. Each has a name, and the current state is stored in a simple string field in the record. If you like to think of a finite state machine as a graph, these are the nodes.
 
 - Zero or more *creators*. Each has a name, and they define actions that can start the lifecycle, setting the state to be some start-state.
 
 - Zero or more *transitions*. Each has a name, and they define actions that can change the state. Again, thinking in terms of a graph, these are the arcs between the nodes.
 
The creators and the transitions are together known as the *steps* of the lifecycle.

There are a variety of ways to limit which users are allowed to perform which steps, and there are ways to attach custom actions (e.g. send an email) both to steps and to states.


# Defining a lifecycle

Any Hobo model can be given a lifecycle like this:

    class Friendship < ActiveRecord::Base
    
      hobo_model
      
      lifecycle do
        ... define lifecyle steps and states ...
      end
      
    end
{.ruby}

Any model that has such a declaration will gain the following features:

 - The lifecycle definition becomes a class called `Lifecycle` which is nested inside the model class (e.g. `Friendship::Lifecycle`) and is a subclass of `Hobo::Lifecycles::Lifecycle`. The class has methods for each of the creators.
 
 - Every instance of the model will have an instance of this class available from the `#lifecycle` method. The instance has methods for each of the transitions:
 
        my_friendship.lifecycle.class # => Friendship::Lifecycle
        my_friendship.lifecycle.reject!(user)
{.ruby}

The `lifecyle` declaration can take two options:

 - `:state_field` - the name of the database field (a string field) to store the current state in. Default '`state`'
 
 - `:key_timestamp_field` - the name of the database field (a datetime field) to store a timestamp for transitions that require a key (discussed later). Set to `false` if you don't want this field. Default '`key_timestamp`'.
 
Note that both of these fields are declared `never_show` and `attr_protected`.

Within the `lifecycle do ... end` a simple DSL is in effect. Using this we can add states and steps to the lifecycle.


## Defining states

To declare states:

    lifecycle do
      state :my_state, :my_other_state
    end
{.ruby}

You can call `state` many times, or pass several state names to the same call.

Each state can have an action associated with it:

    state :active do
      MagicMailer.send [requestee, requester], "Congratulations, you are now friends"
    end
{.ruby}

You can provide the `:default => true` option to have the database default for the state field be this state:

    state :requested, :default => true


## Defining creators

A creator is the starting point for a lifecycle. They provide a way for the record to be created (in addition to the regular `new` and `create` methods). Each creator becomes a method on the lifecycle class. The definition looks like:

    create name, options do ... end
{.ruby}

The name is a symbol. It should be a valid ruby name that does not conflict with the class methods already present on the `Hobo::Lifecycles::Lifecycle` class.

The options are:

 - `:params` - an array of attribute names that are parameters of this create step. These attributes can be set when the creator runs.
 
 - `:become` - the state to enter after running this creator. This does not have to be static but can depend on runtime state. Provide one
   of:
 
   - A symbol -- the name of the state
   - A proc -- if the proc takes one argument it is called with the record, if it takes none it is `instance_eval`'d on the record. Should
     return the name of the state
   - A string -- evaluated as a Ruby expression with in the context of the record
   
 - `:if` and `:unless` -- a precondition on the creator. Pass either:
 
   - A symbol -- the name of a method to be called on the record
   - A string -- a Ruby expression, evaluated in the context of the record
   - A proc -- if the proc takes one argument it is called with the record, if it takes none it is `instance_eval`'d on the record
   
 - `:new_key` -- generate a new lifecycle key for this record by setting the `key_timestamp` field to be the current time.
 
 - `:user_becomes` -- the name of an attribute (typically a `belongs_to` relationship) that will set to the `acting_user`.
 
 - `:available_to` -- Specifies who is allowed access to the creator. This check is in addition to the precondition (`:if` or `:unless`).
   There are a variety of ways to provide the `:available_to` option, discussed later on

The block given to `create` provides a callback which will be called after the record has been created. You can give a block with a single argument, in which case it will be passed the record, or with no arguments in which case it will be `instance_eval`'d on the record.


## Defining transitions

A transition is an arc in the graph of the finite state machine -- an operation that takes the lifecycle from one state to another (or, potentially, back to the same state.). Each transition becomes a method on the lifecycle object (with `!` appended). The definition looks like: 

    transition name, { from => to }, options do ... end
{.ruby}

The name is a symbol. It should be a valid ruby name.

The second argument is a hash with a single item:

    { from => to }
{.ruby}

 (We chose this syntax for the API just because the `=>` is quite nice to indicate a transition)
 
This transition can only be fired in the state or states given as `from`, which can be either a symbol or an array of symbols. On completion of this transition, the record will be in the state give as `to` which can be one of:

 - A symbol -- the name of the state
 - A proc -- if the proc takes one argument it is called with the record, if it takes none it is `instance_eval`'d on the record. Should
   return the name of the state
 - A string -- evaluated as a Ruby expression with in the context of the record

The options are:

 - `:params` - an array of attribute names that are parameters of this transition. These attributes can be set when the transition runs.
    
 - `:if` and `:unless` -- a precondition on the transition. Pass either:
 
   - A symbol -- the name of a method to be called on the record
   - A string -- a Ruby expression, evaluated in the context of the record
   - A proc -- if the proc takes one argument it is called with the record, if it takes none it is `instance_eval`'d on the record
   
 - `:new_key` -- generate a new lifecycle key for this record by setting the `key_timestamp` field to be the current time.
 
 - `:user_becomes` -- the name of an attribute (typically a `belongs_to` relationship) that will set to the `acting_user`.
 
 - `:available_to` -- Specifies who is allowed access to the transition. This check is in addition to the precondition (`:if` or
   `:unless`). There are a variety of ways to provide the `:available_to` option, discussed later on.

The block given to `transition` provides a callback which will be called after the record has been updated. You can give a block with a single argument, in which case it will be passed the record, or with no arguments in which case it will be `instance_eval`'d on the record.


### Repeated transition names

It is not required that a transition name is distinct from all the others. For example, a process may have many stages (states) and there may be an option to abort the process at any stage. It is possible to define several transitions called `:abort`, each starting from a different start state. You could achieve a similar effect by listing all the start states in a single transition, but by defining separate transitions, each one could, for example, be given a different action (block).


## The `:available_to` option

Both create and transition steps can be made accessible to certain users with the `:available_to` option. If this option is given, the step is considered 'publishable', and there will be automatic support for the step in both the controller and view layers.

The rules for the `:available_to` option are as follows. Firstly, it can be one of three special values:

 - `:all` -- anyone, including guest users, can trigger the step

 - `:key_holder` -- (transitions only) anyone can trigger the transition, provided `record.lifecycle.provided_key` is set to the correct
     key. Discussed in detail later.

 - :self -- (transitions only) the `acting_user` and the record the transition is called on must be one and the same. Only makes sense
     for user models of course.
     
If `:avilable_to` is not one of those, it is an indication of some code to run (just like the `:if` option for example):

  - A symbol -- the name of a method to call
   
  - A string -- a ruby expression which is evaluated in the context of the record
  
  - A proc -- if the proc takes one argument it is called with the record, if it takes none it is `instance_eval`'d on the record
  
The value returned is then used to determine if the `acting_user` has access or not. The value is expected to be:

 - A class -- access is granted if the `acting_user` is a `kind_of?` that class.

 - A collection -- if the value responds to `:include?`, access is granted if `include?(acting_user)` is true. e.g. 
 
 - A record -- if the value is neither a class or a collection, access is granted if the value *is* the `acting_user`
 
Some examples:

Say a model has an owner:

    belongs_to :owner, :class_name => "User"

You can just give the name of the relationship (since it is also a method) to restrict the transition to that user:

    :available_to => :owner
    
Or a model might have a list of collaborators associated with it:

    has_many :collaborators, :class_name => "User"
    
Again it's easy to make the lifecycle step available to them only (since the `has_many` does respond to `:include?`):

    :available_to => :collaborators
{.ruby}
    
If you were building more sophisticated role based permissions, you could make sure you role object responds to `:include?` and then say,
for example:

    :available_to => "Roles.editor"
{.ruby}
 
# Validations

TO DO

Short version: validations have been extended so you can give the name of a lifecycle step to the :on option. e.g.

    validates_presence_of :notes, :on => :submit
{.ruby}


# Secure keys

TO DO

The `:new_key` option, and passing `:available_to => :key_holder` have both been mentioned above.

The controller will automatically set `lifecycle.provided_key` from `params[:key]`.


# Routes and controller actions

TO DO

Short version:

For every publishable (i.e. has an `:available_to` option) creator (e.g. 'request' ) you get two actions:

 - `FriendshipsController#request` routed as `/friendships/request` for http GET
 
   This action renders the a form to fill out 
 
 - `FriendshipsController#do_request` routed as `/friendships/request` for http POST
 
   This action is where the form POSTs to. It actually performs the create
 
For every publishable transition (e.g. 'accept' ) you get two actions:

 - `FriendshipsController#accept` routed as `/friendships/:id/accept` for http GET
 
   This action renders the a form to fill out 
 
 - `FriendshipsController#do_accept` routed as `/friendships/:id/request` for http POST
 
   This action is where the form POSTs to. It actually performs the transition


# Lifecycles in Rapid: pages, forms and buttons

TO DO.

Have a look in the auto-generated taglibs:

 - `pages.dryml` contains pages for each publishable create and transition.
 
 - `forms.dryml` contains forms for each publishable create and transition.
 
There are a couple of tags in `rapid_lifecycles.dryml` that provide buttons for executing transition steps (e.g. an "Accept Friendship" button).

# Other bits to do:

Invariants (do we even need/want these?)
