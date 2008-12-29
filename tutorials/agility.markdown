The Agility Tutorial - A simple story manager
{: .document-title}

The full source code for the Agility app is available at [http://github.com/tablatom/agility](http://github.com/tablatom/agility/tree/master).

Contents
{: .contents-heading}

- contents
{:toc}

# Introduction

In this tutorial we'll be creating a simple "Agile Development" application -- _Agility_. The application tracks projects which consist of a number of user stories. Stories have a status (e.g. accepted, under development...) as well as a number of associated tasks. Tasks can be assigned to users, and each user can see a heads-up of all the tasks they've been assigned to on their home page.

This is a bit of an in-at-the-deep-end tutorial -- we build the app the way you would assuming you had already got the hang of the way Hobo works. In the later stages new concepts start coming thick and fast. The goal here is to show you what's possible, and give you a flavour of Hobo-style application development, rather than to provide detailed background on how everything workds. Don't worry about it, it's fun! If you'd rather take things a bit slower, you might prefer the [POD tutorial](http://hobocentral.net/pod-tutorial).


# Part 1 -- Getting Started


## Introduction to Hobo

Hobo is a bunch of extensions to Ruby on Rails that are designed to make developing any kind of web application a good deal faster and more fun. This tutorial is designed to show off Hobo's ability to get quite sophisticated applications up and running extremely quickly. 

While Hobo is very well suited to this kind of throw-it-together-in-an-afternoon application, it is equally useful for longer term projects, where the end result needs to be very meticulously crafted to the needs of its users. Hopefully the tutorial will give you an idea of how to take your Hobo/Rails application much further.

For more info on Hobo please see [hobocentral.net](http://hobocentral.net)

## Before you start

You'll need a working Ruby on Rails setup. We're assuming you know at least the basics of Rails. If not, you should probably work through a Rails tutorial before attempting this one.

And you'll need Hobo! Although Hobo is in fact a group of Rails plugins, it is also available as a gem which gives you the useful `hobo` command:

    $ gem install hobo

Let's get started!

## Create the app

The `hobo` command is like the Rails command, it will create a new blank Rails app that is set-up for Hobo. It's the equivalent of running the `rails` command, installing a few plugins and running a few generators. 

    $ hobo agility

With Hobo, you get a bare-bones application immediately. Let's create the database and then run the app. We first need to use the migration generator to create the basic database:

    $ cd agility
    $ ./script/generate hobo_migration

(Tip: Windows users: Whenever you see `./script/something`, you will need to instead do `ruby script/something`)

Respond to the prompt with `m` and then give the migration a name. Then:

    $ ./script/server

You should be able to sign up. In the next section we'll be starting to flesh out the basics of the app.


## Interface first Hobo style

The next thing we're going to do is sketch out our models. If you're a fully signed up devotee of the Rails Way, that should ring a few alarm bells. What happened to [interface first][]? We do believe in Interface First. Absolutely. But for Hobos, interface first means first priority, not first task. 

[Interface First]: http://gettingreal.37signals.com/ch09_Interface_First.php

The reason is, we think we've rewritten this rule:

> Design is relatively light. A paper sketch is cheap and easy to change. html designs are still relatively simple to modify (or throw out). That's not true of programming. Designing first keeps you flexible. Programming first fences you in and sets you up for additional costs.

In our experience, experimenting with an app by actually building a prototype with Hobo, is actually quicker than creating html designs. How's that for getting real? We could waffle for a good while on this point, but that's probably best saved for a blog post. For now let's dive in and get this app running.


## The models

Let's review what we want this app to do:

 * Track multiple projects
 * Each having a collection of stories
 * Stories are just a brief chunk of text
 * A story can be assigned a current status and a set of outstanding tasks
 * Tasks can be assigned to users
 * Users can get an easy heads up of the tasks they are assigned to

Sounds to me like we just sketched a first-cut of our models. We'll start with:

 * `Project` (with a name)
	has many stories
 * `Story` (with a title, description and status)
	belongs to a project
	has many tasks
 * `Task` (with a description)
	belongs to a story
	has many users (through task-assignments)
 * `User` (we'll stick with the standard fields provided by Hobo)
	has many tasks (through task-assignments)
	
Hopefully the connection between the goal and those models is clear. If not, you'll probably find it gets easier once you've done it a few times. Before long you'll be throwing models into your app without even stopping to write the names down. Of course -- chances are you've got something wrong, made a bad decision. So? Just throw them away and create some new ones when the time comes. We're sketching here!

Here's how we create these with a Hobo generator:

	$ ./script/generate hobo_model_resource project name:string
	$ ./script/generate hobo_model_resource story   title:string body:text status:string
	$ ./script/generate hobo_model_resource task    description:string
	
Task assignments are just a back-end model. They don't need a controller, so:
	
	$ ./script/generate hobo_model task_assignment
	
The field declarations have been created by the generators, but not the associations. Go ahead and add the associations, just below the `fields do ... end` declaration in each model, as follows:

#### `app/models/project.rb`

    class Project < ActiveRecord::Base
      ...
      has_many :stories, :dependent => :destroy
      ...
    end
{: .ruby}
    
### `app/models/story.rb`

    class Story < ActiveRecord::Base
      ...
      belongs_to :project
      
      has_many :tasks, :dependent => :destroy
      ...
    end
{: .ruby}

### `app/models/task.rb`

    class Task < ActiveRecord::Base
      ...
      belongs_to :story

      has_many :task_assignments, :dependent => :destroy
      has_many :users, :through => :task_assignments
      ...
    end
{: .ruby}

### `app/models/task_assignment.rb`

    class TaskAssignment < ActiveRecord::Base
      ...
      belongs_to :user
      belongs_to :task
      ...
    end
{: .ruby}

### `app/models/user.rb`

    class User < ActiveRecord::Base
      ...
      has_many :task_assignments, :dependent => :destroy
      has_many :tasks, :through => :task_assignments
      ...
    end
{: .ruby}

Now watch how Hobo can create a single migration for all of these:

	$ ./script/generate hobo_migration
	
Fire up the app. It's not a polished UI of course, but we do actually have a working application. Make sure you are logged in as an administrator (e.g. the user who signed up first), and spend a few minutes populating the app with projects, stories and tasks. 

With some more very simple changes, and without even touching the views, we can get surprisingly close to a decent UI.


# Part 2 -- Removing actions

By default Hobo has given us a full set of restful actions for every single model/controller pair. Many of these routes are inappropriate for our application. For example, why would we want an index page listing every Task in the database? We only really want to see tasks listed against stories and users. We need to disable the routes we don't want.

There's an interesting change of approach here that often crops up with Hobo development. Normally you'd expect to have to build everything yourself. With Hobo, you often get given everything you want and more besides. Your job is to take away the parts that you *don't* want.

Here's how we would remove, for example, the index action from TasksController. In `app/controllers/tasks_controller.rb`, change 

	auto_actions :all
{: .ruby}
	
To

	auto_actions :all, :except => :index
{: .ruby}
	
Refresh the browser and you'll notice that Tasks has been removed from the main nav-bar. Hobo's page generators adapt to changes in the actions that you make available.

Here's another similar trick. Browse to one of your projects. You'll see the page says "No stories to display" but there's no way to add one. Hobo has support for this but we need to switch it on. Add the following declaration to the stories controller:

    auto_actions_for :project, [:new, :create]
    
This creates nested routes and their corresponding actions:

 - `/project/123/stories/new` routed to `StoriesController#new_for_project`
 - `/project/123/stories` (POST) routed to `StoriesController#create_for_project`
 
Hobo's page generators will respond to the existence of these routes and add a "New Story" link to the project page, and an appropriate "New Story" page.

Create a story and you'll see the story has the same issue with it's task - there's no way to create one. Again we can add the `auto_actions_for` declaration to the tasks controller, but this time we'll only ask for a `create` action and not a `new` action:

    auto_actions_for :story, :create
{: .ruby}
    
Hobo's page generator can cope with the lack of a 'New Task' page -- it gives you an in-line form on the story page.

We'll now continue and configure the available actions for all of the controllers. So far we've seen the black-list style where you list what you *don't* want:

	auto_actions :all, :except => :index
{: .ruby}

There's also white-list style where you list what you do want, e.g.

    auto_actions :index, :show
{: .ruby}

There's also a handy shortcut to get just the read-only routes (i.e. the ones that don't modify the database)

	auto_actions :read_only
{: .ruby}
	
The opposite is handy for things that are manipulated by ajax but never viewed directly:

	auto_actions :write_only # short for -- :create, :update, :destroy
{: .ruby}

Work through your controllers and have a think about which actions you want. You need to end up with:

 * Projects: `auto_actions :all`
 * Stories `auto_actions :all, :except => :index`
 * Tasks: `auto_actions :write_only, :edit`

Have a play with the application with this set of actions in place. Looking pretty good!


# Part 3 -- Permissions

So far we've only done two things to our app: created some models & controllers, and specified which actions are available. There's one more thing we typically do when creating a new Hobo app, before we even touch the view layer. We modify permissions in the model layer.

## Introduction to permissions

You might have noticed methods like this one in the generated models:

	def create_permitted?
	  acting_user.administrator?
	end
{: .ruby}

That tells Hobo that only administrators are allowed to create this kind of model. Before every create, update and delete (destroy) operation, Hobo's controller calls one of these methods with `acting_user` set to the logged in user. Only if the method returns true is the operation allowed to continue.

Furthermore, the *Rapid* DRYML tag library (that's the part of Hobo that creates the UI automatically for you) knows how to interrogate the permissions and adapt accordingly. For example, Rapid will only generate a "New Project" link if the current user has permission to create a project.

You can see this feature in action by changing user (use the "user changer" menu in the top left) as you browse around the app. You'll notice that all the 'new' and 'edit' links disappear if you are a guest. If you experiment by changing `acting_user.administrator?` to `true` in some permission methods, you'll see operations start to become available.


## Customise the permissions in Agility

For the purposes of the tutorial you can make your own decisions about who should be allowed to do what. In the spirit of agile methods, we probably don't want to lock things down too much. Here's a suggestion:

 * Only administrators can create, edit and delete projects
 * Stories and tasks are open to change by all signed up users.

A permission that says "only signed up users" looks like this:

	def create_permitted?
	  acting_user.signed_up?
	end
{: .ruby}

(Note: there is also `acting_user.guest?`)
	
You might need to sign up a new user so you've got a non-admin to test things with. 


## Permissions for data integrity

The permissions system is not just for providing operations to some users but not to others. It is also used to prevent operations that don't make sense for anyone. For example, you've probably noticed that the default UI allows stories to be moved from one project to another. That's arguably not a sensible operation for *anyone* to be doing. Before we fix this, browse to an "Edit Story" page and notice the menu that lets you choose a different project. Now prevent the project from changing with this method in `story.rb`:

	def update_permitted?
	  acting_user.signed_up? && !project_changed?
	end
{: .ruby}

Refresh the browser and you'll see that menu removed from the form automatically. 

The `update_permitted?` method can take advantage of the "dirty tracking" features in ActiveRecord. If you're savvy with ActiveRecord you might notice something unusual there - those `*_changed?` methods are only available on primitive fields. Hobo's model extensions give you methods like that for `belongs_to` associations too.

Now make a similar change to prevent tasks being moved from one story to another.


## Associations

Although we have modelled the assignment of tasks to users, at the moment there is no way for the user to set these assignments. We'll add that to the task edit page. Create a task and browse to the edit page - only the description is editable. Hobo does provide support for "multi-model" forms, but it is not active by default. To specify that a particular association should be accessible to updates from the form, you need to declare `:accessible => true` on the association. In `task.rb`, edit the `has_many :users` association as follows:

    has_many :users, :through => :task_assignments, :accessible => true
{.ruby}

Without that declaration, the permission system was reporting that this association was not editable. Now that the association is "accessible", the permission system will check for create and destroy permission on the join model `TaskAssignments`. As long as the current user has those permissions, the task edit page should now include a nice javascript powered control for assigning users in the edit-task page.


# Part 4 -- Customising views

It's pretty surprising how far you can get without even touching the view layer. That's the way we like to work with Hobo - get the models and controllers right and the view will probably get close to what you want. From there you can override just those parts of the view that you need to.

We do that using the DRYML template language which is part of Hobo. DRYML is tag based -- it allows you to define and use your own tags right alongside the regular HTML tags. Tags are like helpers, but a lot more powerful. DRYML is quite different to other tag-based template languages, thanks to features like the implicit context and nestable parameters. DRYML is also an extension of ERB so you can still use the ERB syntax you're familiar with from Rails. 

DRYML is probably the single best part of Hobo. It's very good at high-level re-use because it allows you to make very focussed changes if a given piece of pre-packaged HTML is not *quite* what you want.

A full coverage of DRYML is well beyond the scope of this tutorial. Instead we're going to take a few specific examples of changes we'd like to make to Agility, and see how they're done.


## Add assigned users to the tasks

At the moment, the only way to see who's assigned to a task is to click the task's edit link. Not good. Let's add a list of the assigned users to each task when we're looking at a story.

DRYML has a feature called *polymorphic tags*. These are tags that are defined differently for different types of object. Rapid makes use of this feature with a system of "cards". The tasks that are displayed on the story page are rendered by the `<card>`. You can define custom cards for particular models. Furthermore, if you call `<base-card>` you can define your card by tweaking the default, rather than starting from scratch. This is what DRYML is all about. It's like a smart-bomb, capable of taking out little bits of unwanted HTML with pin-point strikes and no collateral damage.

The file `app/views/taglibs/application.dryml` is a place to put tag definitions that will be available throughout the site. Add this definition to that file:

    <extend tag="card" for="Task">
      <old-card merge>
        <append-body:>
          <div class="users">
            Assigned users: <repeat:users join=", "><a/></repeat><else>None</else>
          </div>
        </append-body:>
      </old-card>
    </extend>
{: .dryml}
	
OK there's a lot of new concepts thrown at you at once there :-) 
	
First off, refresh the story page. You'll see that in the cards for each task there is now a list of assigned users. The users are clickable - they link to each users home page (which doesn't have much on it at the moment).

The `<extend>` tag is used to extend any tag that's already defined. The body of `<extend>` is our new definition. It's very common to want to base the new definition on the old one, for example, we often want to insert a bit of extra content as we've done here. We can do that by calling the "old" definition, which is available as `<old-card>`. We've passed the `<append-body:>` parameter to `<old-card>` which, in a startling twist, is used to append content to the body of the card. Some points to note:
	
 * The `<repeat>` tag provides a `join` attribute which we use to insert the commas
 * The link is created with a simple empty `<a/>`. It links to the 'current context' which, in this case, is the user.
 * The `:users` in `<repeat:users>` switches the context. It selects the `users` association of the task.
 * DRYML has a multi-purpose `<else>` tag. When used with repeat, it provides a default for the case when the collection is empty.
	
	
## Add a task summary to the user's home page

Now that each task provides links to the assigned users, the user's page is not looking great. Rapid has rendered cards for the task-assignments but there's no meaningful content in them. What we'd like to see there is a list of all the tasks the user has been assigned to. Having them grouped by story would be helpful too.

To achieve this we want to create a custom template for `users/show`. If you look in `app/views/users` you'll see that it's empty. When a page template is missing, Hobo tries to fall back on a defined tag. For a 'show' page, that tag is `<show-page>`. The Rapid library provides a definition of `<show-page>`, so that's what we're seeing at the moment. As soon as we create `app/views/users/show.dryml`, that file will take over from the generic `<show-page>` tag. Try creating that file and just throw "Hello!" in there for now. You should see that the user's show page now displays just "Hello!" and has lost all of the page styling. 

If you now edit `show.dryml` to read "`<show-page/>`" you'll see we're back where we started. The `<show-page>` tag is just being called explicitly instead of by convention. Rapid has generated a custom definition of `<show-page for="User">`. You can find this in `app/views/taglibs/auto/rapid/pages.dryml`. Don't edit this file! Your changes will be overwritten. Instead use this file as a reference so you can see what the page provides, and what parameters there are (the `param` attributes). You'll see:

    <section param="content-body">
{: .dryml}
    
That means you can change that part of the page entirely, like this:

	<show-page>
	  <content-body:>Hello!</content-body:>
	</show-page>
{: .dryml}

Edit show.dryml to look like that. The "Hello!" message is back, but now it's embedded in the properly marked-up page. 

Now let's get the content we're after - the user's assigned tasks, grouped by story. It's only five lines of markup:

	<show-page>
	  <content-body:>
	    <h3><Your/> Assigned Tasks</h3>
	    <repeat with="&@user.tasks.group_by(&:story)">
	      <h4>Story: <a with="&this_key"/></h4>
	      <collection/>
	    </repeat>
	  </content-body:>
	</show-page>
{: .dryml}

Again - lots of new stuff there. Let's quickly run over what's going on

 * The `<Your>` tag is a handy little gadget. It outputs "Your" if the context is the current user, otherwise it outputs the user's name. You'll see "Your Assigned Tasks" when looking at yourself, and "Fred's Assigned Tasks" when looking at Fred.
	
 * We're using `<repeat>` again, but this time we're setting the context to the result of a Ruby expression (`with="&...expr..."`). The expression `@user.tasks.group_by(&:story)` gives us the grouped tasks.

 * We're repeating on a hash this time. Inside the repeat `this` (the implicit context) will be an array of tasks, and `this_key` will be the story. So `<a with="&this_key">` gives us a link to the story. 
	
 * `<collection>` is used to render a collection of anything in a `<ul>` list. By default it renders `<card>` tags. To change this just provide a body to the `<collection>` tag.
	
That's probably a lot to take in all at once -- the main idea here is to throw you in and give you an overview of what's possible. The [DRYML Guide][] will shed more light.

[DRYML Guide]: http://hobocentral.net/docs/dryml
	
## Improve the project page with a searchable, sortable table

The project page is currently workable, but we can easily improve it a lot. Rapid provides a tag `<table-plus>` which renders a table with support for sorting by clicking on the headings, and a built-in search bar for filtering the rows displayed. Searching and sorting are done server-side so we need to modify the controller as well as the view for this enhancement.

As with the user's show-page, to get started put a simple call to `<show-page/>` in `app/views/projects/show.dryml`

To see what this page is doing, take a look at `<def tag="show-page" for="Project">` in `pages.dryml` (in `app/views/taglibs/auto/rapid`). Notice this tag:
    
    <collection:stories param/>
{: .dryml}

    
That's the part we want to replace with the table. Note that when a `param` attribute doesn't give a name, the name defaults to the same name as the tag. Here's how we would replace that `<collection>` with a simple list of links:

	<show-page>
	  <collection: replace>
	    <div>
	      <repeat:stories join=", "><a/></repeat>
	    </div>
	  </collection:>
	</show-page>
{: .dryml}

You should now see that in place of the story cards, we now get a simple comma-separated list of links to the stories. Not what we want of course, but it illustrates the concept of replacing a parameter.

Here's how we get the table-plus:

	<show-page>
	  <collection: replace>
        <table-plus:stories fields="this, status">
          <empty-message:>No stories match your criteria</empty-message:>
        </table-plus>
	  </collection:>
	</show-page>
{: .dryml}

The `fields` attribute to `<table-plus>` lets you specify a list of fields that will become the columns in the table. We could have said `fields="title, status"` which would have given us the same content in the table, but by saying `this`, the first column contains links to the stories, rather than just the title as text.

We could also add a column showing the number of tasks in a story. Change to `fields="this, tasks.count, status"` and see that a column is added with a readable title "Tasks Count".

To get the search feature working, we need to update the controller side. Add a `show` method to `app/controllers/projects_controller.rb` like this:
	
	def	show
	  @project = find_instance
	  @stories = 
	    @project.stories.apply_scopes(:search    => [params[:search], :title],
	                                  :order_by  => parse_sort_param(:title, :status))
	end
{: .ruby}

Then get the `<table-plus>` to use `@stories`:

    <table-plus with="&@stories" fields="this, tasks.count, status">
{: .dryml}

(To do -- explain how that works!)
	
# Part 5 -- odds and ends

We're now going to work through some more easy but very valuable enhancements to the app. We're going to add:

 * A menu for story statuses. The free-form text field is a bit poor after all. We'll do this first with a hard-wired set of options, and then add the ability to manage the set of available statuses.

 * Add filtering o stories by status to the project page

 * Drag and drop re-ordering of tasks. This effectively gives us prioritisation of tasks.

 * Markdown or textile formatting of stories. This is implemented by changing *one symbol* in the source code.

Off we go.

## Story status menu.

We're going to do this in two stages - first a fixed menu that would require a source-code change if you ever need to alter the available statuses. We'll then remove that restriction by adding a StoryStatus model. We'll also see the migration generator in action again.

The fixed menu is brain-dead simple. Track down the declaration of the status field in `story.rb` (it's in the `fields do ... end` block), and change it to read something like:

	status enum_string(:new, :accepted, :discussion, :implementation) # etc.
{: .ruby}
	
Job done. If you want the gory details, `enum_string` is a *type constructor*. It creates an anonymous class that represents this enumerated type (a subclass of String). You can see this in action by trying this in the console:

	>> Story.find(:first).status.class
{: .ruby}

The menu is working in the edit-story page now. It would be nice though if we had a ajaxified editor right on the story page. Edit `app/views/stories/show.dryml` to be:

	<show-page>
	  <field-list: tag="editor"/>
	</show-page>
{: .dryml}
	
What did that do? `<show-page>` uses a tag `<field-list>` to render a table of fields. DRYML's parameter mechanism allows the caller to customize the parameters that are passed to `<field-list>`. On our story page the field-list contains only the status field. By default `<field-list>` uses the `<view>` tag to render read-only views of the fields, but that can be changed by passing a tag name to the `tag` attribute. We're passing `editor` which is a tag for creating ajax-style in-place editors. 
	
	
## Have a configurable set of statuses

In order to support management of the statuses available, we'll create a StoryStatus model

	$ ./script/generate hobo_model_resource story_status name:string
	
Whenever you create a new model + controller with Hobo, get into the habit of thinking about permissions and controller actions. In this case, we probably want only admins to be able to manage the permissions. As for actions, we probably only want the write actions, and the index page:

	auto_actions :write_only, :new, :index
{: .ruby}
	
Next, remove the 'status' field from the `fields do ... end` block in the Story model. Then add an association with the StoryStatus model:

	belongs_to :status, :class_name => "StoryStatus"
{: .ruby}
	
Now run the migration generator

	$ ./script/generate hobo_migration
	
You'll see that the migration generator considers this change to be ambiguous. Whenever there are columns removed *and* columns added, the migration generator can't tell whether you're actually removing one column and adding another, or if you are renaming the old column. It's also pretty fussy about what it makes you type. We really don't want to play fast and lose with your precious data, so to confirm that you want to drop the 'status' column, you have to type in full: "drop status".

Once you've done that you'll see that the generated migration includes the creation of the new foreign key and the removal of the old status column.

You can always edit the migration before running it. For example you could create some initial story statuses by adding this code to the `self.up` method:

    statuses = %w(new accepted discussion implementation user_testing deployed rejected)
    statuses.each { |status| StoryStatus.create :name => status }
{: .ruby}

That's it. The page to manage the story statuses should appear in the main navigation.

Now that we've got more structured statuses, let's do something with them...

## Filtering stories by status

Rapid's `<table-plus>` is giving us some nice searching and sorting features on the project page. We can easily add some filtering into the mix, so that it's easy to, say, see only new stories. 

First we'll add the filter control to the header of the table-plus. Rapid provides a `<filter-menu>` tag which is just what we need. We want to add it to the header section, before the stuff that's already there. In DRYML, you can prepend or append content to any named parameter. `<table-plus>` has a `header:` parameter, so we can use `<prepend-header:>`, like this:

	<table-plus fields="this, status">
	  <prepend-header:>
	    <div class="filter">
	      Display by status: <filter-menu param-name="status" options="&StoryStatus.all"/>
	    </div>
	  </prepend-header:>
	</table-plus>
{: .dryml}

To make the filter look right, add this to `public/stylesheets/application.css`

    .show-page.project .filter {float: left;}
    .show-page.project .filter form, .show-page.project .filter form div {display: inline;}
	
If you try to use the filter, you'll see it adds a `status` parameter in the query string. We need to pick that up and do something useful with it in the controller. We can use the `apply_scopes` method again, which is already being used, so it's just a matter of adding one more keyword argument:

Needs support in the controller. Add this option to the `apply_scopes` call in `ProjectsController#show`:

	:status_is => params[:status]
{: .ruby}
	
Status filtering should now be working.

(To do: explain the scope being used there)


# Task re-ordering

We're now going to add the ability to re-order a story's tasks by drag-and-drop. There's support for this built into Hobo, so there's not much to do. First we need the `acts_as_list` plugin:

	./script/plugin install acts_as_list
	
Now two changes to our models:
	
 * Task needs `acts_as_list :scope => :story`
 * Story needs `:order => :position` on the `has_many :tasks` declaration

The migration generator knows about `acts_as_list`, so you can just run it and you'll get the new position column on Task.

	$ ./script/generate hobo_migration
	
And that's it!

You'll notice a slight glitch -- the tasks position has been added to the new-task and edit-task forms. We don't want that. We'll fix it by customising the Task form.

In `application.dryml` add:

    <extend tag="form" for="Task">
      <old-form merge>
        <field-list: fields="description, users"/>
      </old-form>
    </extend>
{.dryml}


On the task edit page you might also have noticed that Rapid didn't manage to figure out a destination for the cancel link. You can fix that by editing `tasks/edit.dryml` to be:

    <edit-page>
      <form:>
        <cancel: with="&this.story"/>
      </form:>
    </edit-page>
    
This is a good demonstration of DRYML's nested parameter feature. The `<edit-page>` makes it's form available as a parameter, and the form provides a `<cancel:>` parameter. We can drill down from the edit-page to the form and then to the cancel link to pass in a custom attribute. You can do this to any depth.
    
	
# Markdown / Textile formatting of stories

We'll wrap up this section with a really easy one. Hobo renders model fields based on their type. You can add your own custom types and there's bunch built it, including textile and markdown formatted strings.

Location the `fields do ... end` section in the Story model, and change

	body :text
{: .ruby}
	
To 

	body :markdown # or :textile
{: .ruby}

You may need to install the relevant ruby gem: either BlueCloth (markdown) or RedCloth (textile)


# Part 6 -- Project Ownership

The next goal for Agility is to move to a full mutli-user application, where users can create their own projects and control who has access to them. Rather than make this change in one go, we'll start with a small change that doesn't do much by itself, but is a step in the right direction: making projects be owned by users.

Add the following to the Project model:

	belongs_to :owner, :class_name => "User", :creator => true
{: .ruby}
	
There's a Hobo extension there: `:creator => true` tells Hobo that when creating one of these things, the `owner` association should be automatically set up to be the user doing the create.

We also need the other end of this association, in the User model:

	has_many :projects, :class_name => "Project", :foreign_key => "owner_id"
{: .ruby}
	
How should this effect the permissions? Certain operations on the project should probably be restricted to its owner:

	def create_permitted?
	  owner == acting_user
	end

  def update_permitted?
	  acting_user.administrator? || (acting_user == owner && !owner_changed?)
	end

	def destroy_permitted?
	  acting_user.administrator? || acting_user == owner
	end
{: .ruby}
	
One thing worth noting in the `creatable_by?` method. We assert that `owner == user`. This is very often found in conjunction with `:creator => true`. Together, these mean that the current user can create their own projects only, and the "Owner" form field will be automatically removed from the new project form.

Run the migration generator to see the effect on the app:

    $ ./script/generate hobo_migration
    
Finally lets add a handy list of "Your Projects" to the home page. Edit the content-body section of `app/views/front/index.dryml` to be:

    <section class="content-body" if="&logged_in?">
      <h3>Your Projects</h3>
      <collection:projects with="&current_user"/>
    </section>
    
One thing you'll notice is that the project cards have a link to the project owner. In general that's quite useful, but in this context it doesn't make much sense. DRYML is very good at favouring context over consistency -- we can remove that link very easily:

    <section class="content-body">
      <h3>Your Projects</h3>
      <collection:projects with="&current_user"><card without-creator-link/></collection>
    </section>
    

# Part 7 -- Granting read access to others

Now that we've got users owning their own projects, it seems wrong that any signed up user can view any project. On the other hand it wouldn't make any sense to hide the project from everyone. What we need is a way for the project owner to grant others access.

We can model this with a ProjectMembership model that represents access for a specific user and project:

	$ ./script/generate hobo_model_resource project_membership
	
First remove the actions we don't need on the `ProjectMembershipsController`:

    auto_actions :write_only
{: .ruby}

Next, add the associations to the model:

	belongs_to :project
	belongs_to :user
{: .ruby}
	
Then permissions -- only the project owner (and admins) can manipulate these:

	def create_permitted?
	  acting_user.administrator? || acting_user == project.owner
	end

	def update_permitted?
	  acting_user.administrator? || acting_user == project.owner
	end

	def destroy_permitted?
	  acting_user.administrator? || acting_user == project.owner
	end

	def view_permitted?(attribute)
	  true
	end
{: .ruby}
	
Let's do the other ends of those two belongs-to associations. In the Project model:
	
	has_many :memberships, :class_name => "ProjectMembership", :dependent => :destroy
	has_many :members, :through => :memberships, :source => :user
{: .ruby}
	
And in the User model (remember that User already has an association called `projects` so we need a new name):

	has_many :project_memberships, :dependent => :destroy
  	has_many :joined_projects, :through => :project_memberships, :source => :project
{: .ruby}
  
Note that users now have two collections of projects: `projects` are the projects that users owns, and `joined_projects` are the projects they have joined as a member.

We can now define view permission on projects, stories and tasks according to project membership.

In Project:

	def view_permitted?(attribute)
    acting_user.administrator? || acting_user == owner || acting_user.in?(members)
	end
{: .ruby}
  
In Story:

	def view_permitted?(attribute)
	  project.viewable_by?(acting_user)
	end
{: .ruby}

In Task:

	def view_permitted?(attribute)
	  story.viewable_by?(acting_user)
	end
{: .ruby}
	
Finally, now that not all projects are viewable by all users, the projects index page won't work too well. In addition, the top-level New Project page at `/projects/new` isn't suited to our purposes any more. It will fit better with Hobo's RESTful architecture to create projects for specific users, e.g. at `/users/12/projects/new`

So we'll modify the actions provided by the projects controller to:

    auto_actions :show, :edit, :update, :destroy
    
    auto_actions_for :owner, [:new, :create]
{: .ruby}

Note that there won't be a link to that new-project page by default -- we'll add one in the next section.

	
## The view layer
	
We need a UI to manage these memberships. We're going to do it all ajax-style on the project show page. First up, we'll add a side-bar to the projects/show page that lists the members of the projects. The Rapid library and the Clean theme work together to make these kinds of layout easy. The `<section-group>` tag is used whenever we want to lay out a group of `<section>` tags or `<aside>` tags. Here's the markup for a page with a simple aside layout:

    <page>
      <content:>
        <section-group>
          <section with-flash-messages>
            Main content
          </section>
          <aside>
            Aside content
          </aside>
        </section-group>
      </content:>
    </page>
{: .dryml}

Start by adding that markup to your project show page. Note the use of the `with-flash-messasges` attribute to move the flash messages into the main section:

    <show-page>
      <content:>
        <section-group>
          <section with-flash-messages>
            Main content
          </section>
          <aside>
            Aside content
          </aside>
        </section-group>
      </content:>
      
      <collection: replace>
        ...
      </collection>
    </show-page>
{: .dryml}

You will now have a page with a sidebar, but of course you've also lost all the content that was on that page, because we've entirely overwritten the body of the `<content:>` parameter. DRYML provides the ability to recall the original parameter content with `<param-content for="content"/>`. Edit the page to look like this:

    <show-page>
      <content:>
        <section-group>
          <section with-flash-messages>
            <param-content for="content"/>
          </section>
          <aside>
            Aside content
          </aside>
        </section-group>
      </content:>
      
      <collection: replace>
        ...
      </collection>
    </show-page>
{: .dryml}


You should now have the original page back with the sidebar added. We'll display the members of the project in the side-bar using the `<collection>` tag which we've seen before:

	...
	<aside>
    <h3>Project Members</h3>
	  <collection:members/>
	</aside:>
	...
{: .dryml}
	
## A form with auto-completion
	
Now we'll create the form to add a new person to the project. We'll set it up so that you can type the user's name, with autocompletion, in order to add someone to the project.

First we need the controller side of the auto-complete. We're going to add an auto-completer to ProjectsController that will only complete the names of people that are not already members of the project. Hobo's automatic scopes come very handy. Add this declaration to `projects_controller.rb`:

	autocomplete :new_member_name do
	  project = find_instance
	  hobo_completions :username, User.without_joined_project(project).is_not(project.owner)
	end
{: .ruby}

You can read this as: create an auto-complete action called '`new_member_name`' that finds users that are not already members of the project, and not the owner of the project and completes the `:username` field.

Now for the form in projects/show.dryml. We'll use Hobo's ajax part mechanism to refresh the collection without reloading the page:

    ...
    <aside:>
      <h2>Project Members</h2>
      <collection:members part="members"/>
   
      <form:memberships.new update="members" reset-form refocus-form>
        <div>
          Add a member: 
          <name-one:user complete-target="&@project" completer="new_member_name"/>
        </div>
      </form>
    </aside:>
	...
{: .dryml}
	
Some things to note:

 - The `<collection>` tag has `part="members"`. This creates a re-loadable section of the page, much as you would achieve with partials in regular Rails.

 - The `<form>` tag has `update="members"`. The presence of this attribute turns the form into an ajax form. Submitting the form will cause the "members" part to be updated.
	
 - The `<name-one>` tag creates an input field for the user association with auto-completion. The `complete-target` and `completer` attributes are used to determine the URL of the completer action.

## Removing members

The sidebar we just implemented has an obvious draw-back -- there's no way to remove members. In typical RESTful style, removing a member is achieved by deleting a membership. What we'd like is a delete button on each card that removes the membership. That means what we really want are *Membership* cards in the sidebar (at the moment they are User cards). Change:

    <collection:members part="members"/>
{: .dryml}
    
To:

    <collection:memberships part="members"/>
{: .dryml}
    
Problem -- the membership card doesn't display the users name. There are two ways we could fix this. We could either customise the global membership card using `<extend tag="card" for="Membership">` in `application.dryml`, or we could customise *this particular usage* of the membership card. Let's do the latter. Modify the `<collection:memberships>` as follows:
    
    <collection:memberships part="members">
      <card><heading:><a:user/></heading:></card>
    </collection>
{: .dryml}

## Final steps

There's just a couple of things to do to round this part of the tutorial off. Firstly, you might have noticed there's no place to create a new project at the moment. There's also no place that list "Projects you have joined". We'll add both of those to the front page, in the place we currently have a list of "Your projects". Replace that entire `<section class="content-body">` with the following DRYML:
    
    <section with="&current_user" class="content-body" if="&logged_in?">
      <h3>Your Projects</h3>
      <collection:projects><card without-creator-link/></collection>
      
      <a:projects action="new">New Project</a>
      
      <h3>Projects you have joined</h3>
      <collection:joined-projects><card without-creator-link/></collection>
    </section>
{: .dryml}

Notice how we set the context on the entire section to be the current user (`with="&current_user"`). That makes the mark-up inside the section much more compact and easy to read.


# Part 8 -- Granting write access to others

It's not enough just to allow others to view your projects, you need to allow some people to make changes to. The goal of this part of the tutorial is to add a checkbox "Contributor" next to each person in the side-bar.

The steps are:

 - Add a boolean field "contributor" to the ProjectMembership model
 - Modify the permissions of stories and tasks so that users with this field set to true on their project membership can make changes
 - Use the `<editor>` tag to create an ajax editor for that field in the ProjectMembership card.
	
That's all the hints we're going to give you for this one -- good luck!

Oh OK one more hint, here's some associations that might be handy in the Project model:

	has_many :contributor_memberships, :class_name => "ProjectMembership", :scope => :contributor
	has_many :contributors, :through => :contributor_memberships, :source => :user
{: .ruby}	

And a helper method that might come in handy from your permission methods:

	def accepts_changes_from?(user)
	  user.administrator? || user == owner || user.in?(contributors)
	end
{: .ruby}


# Part 9 -- Ideas for extending the app.


## Milestones

A pretty obvious addition is to have project milestones, and be able to associate stories with milestones.

## Add comments to stories

It's always useful to be able to have a discussion around things, and a trail of comments is a nice easy way to support this.

## Better users/show page

The current users show page could be improved a lot. For example, it doesn't give any indication of the different projects that stories belong to. What else would be useful on this page?


# Appendix -- Styling the Application

**NOTE: This section is a bit out of date. It will mostly work but there might be some style glitches**

The default Hobo theme “Clean” provides comprehensive but minimal styling for all of Hobo’s generic pages and tags. When styling your app you have a choice between creating your own theme from scratch or tweaking an existing theme to suit your needs. The Clean theme has been designed with this in mind, it can be adapted to look very different with only a small amount of effort. 

In this section we will adapt our existing theme to create a new look for our app. We will make our changes in `public/stylesheets/application.css` which is initially empty. This stylesheet is applied after our theme stylesheet so we can override the theme's styles here instead of editing the theme stylesheet directly. This approach means that we can upgrade the theme in the future with minimal effort, although it also means that our stylesheets will be bigger than they could be, so the approach is better suited to small and medium sized projects. For larger projects it might be better to create a new theme, perhaps based on an existing one, or do away with themes altogether and do all the styling in the application stylesheet.

In order to override our existing theme styles we need to know about the styles that are being applied. For this we can look at the existing theme file in `public/hobothemes/clean/stylesheets/clean.css`. Another good source for this information is Firebug in Firefox where we can examine the various page elements to discover what styling is being applied.

Hobo's tags add various CSS classes to the output elements to help with styling. These are typically the name of the tag that was used to generate the output and the name of the model or field in context. A few examples of this are:

An index page for "Project" adds the following classes to `<body>`:
`<body class="index-page project">`

A show page for "Project" adds the following classes to `<body>`:
`<body class="show-page project">` on /projects/1

The `<view>` tag when applied to a "Project" name will output:
`<span class="view project-name">My Project</span>`

The `<card>` tag when applied to a "Project" will output:
`<div class="card project linkable">`
  
With these classes it becomes very easy to style specific elements on the page.

For example:

`.card.project` - Style all "project" cards
`.index-page .card.project` - Style "project" cards on index pages
`.show-page.project .card.story` - Style "story" cards on the "project" show page

We'll now add some styling to `public/stylesheets/application.css` to make our Agility app look a bit different.

The first thing we'll do is switch from a "boxed in" look to an horizontally open style. To do this we'll use a background image to draw a horizontal top banner across the whole page and change the page background colour to white. 

    html, body {
    	background-image: url(/images/header.png);
    	background-position: top left;
    	background-repeat: repeat-x;
    	background-color: white;
    }

Next we'll make the page a bit wider by default, make the header taller.

    body {width: 860px; background: none;}

    .page-header {height: 176px; padding: 0; margin-top: 0;}

Next we'll want to position the contents of the page header differently since we've increase it's height. We'll start by increasing the size and padding on the application name.

    .page-header h1 {
    	margin: 0; padding: 50px 30px 0;
    	font-family: "Lucida Grande", Tahoma, Arial, sans-serif; font-size: 42px; font-weight: bold;
    	text-transform: lowercase;
    }

Next we'll move the main navigation bar to the top right of the page and change the way it looks.

    .page-header .main-nav {
    	position: absolute; top: 0; right: 0;
    }
    .page-header .main-nav li {margin-right: 1px;}
    .main-nav a, .main-nav a:hover {
    	padding: 37px 6px 5px; min-width: 95px;
    	text-shadow: none;
    	border: 1px solid black; border-width: 0 0 0 1px; background-color: #D61951;
    }
    .main-nav a:hover {
    	background-color: #AD163D;
    }

Next we need to reposition the account navigation and search bar. We'll also need to reposition our development-mode user changer.

    .account-nav {
    	position: absolute; top: 70px; right: 15px;
    	font-size: 11px;
    }
    .account-nav a {color: #bbb;}

    .page-header div.search {
    	top: auto; bottom: 0; right: 5px; z-index: 10;
    }
    select.dev-user-changer {top: 100px; left: auto; right: 15px; height: auto;}

Now that we've finished the page header we want to customise the content section of the page.

    .page-content {background: none;}
    .content-header, .content-body {margin: 0 25px 15px;}

    body {
    	color: #555;
    	font: 14px "Trebuchet MS", Arial, sans-serif; line-height: 150%;
    }
    h1, h2, h3 {font-weight: normal; line-height: 100%; text-transform: lowercase; color: #D61951;}
    h1 {margin: 20px 0 10px; font-size: 26px;}
    h2 {margin: 15px 0 10px; font-size: 18px;}
    h3 {margin: 10px 0 5px;  font-size: 16px;}
    h4 {margin: 10px 0 5px;  font-size: 14px;}
    h5 {margin: 10px 0 5px;  font-size: 12px;}
    h6 {margin: 10px 0 5px;  font-size: 10px;}

    .show-page .content-header, .primary-collection h2 {border-bottom: 1px solid #ccc;}
    .front-page .welcome-message {border: none;}

    .card {border: none; background: #f2f2f2;}
    a, a:hover, .card a, .card a:hover {background: none; color: #1D7D39;}

Finally we'll customise the look of the aside section which is used on the project show page.

    .aside {padding: 20px; margin: 40px 25px 0 0;}
    .aside-content h2, .aside-content h3 {border-bottom: 1px solid #ccc; margin-top: 0;}
