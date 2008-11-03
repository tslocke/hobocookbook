# The DRYML Guide
{: .document-title}

Welcome to the DRYML Guide. If you want to learn all the ins and outs of DRYML and become a master of quick and elegant view templates, you're in the right place. If you're very new to Hobo and DRYML you might not be better off with something like the Agility tutorial. This guide is somewhere between a tutorial and a reference, designed to fill in the gaps for people who have already got the hang of the basics. Right, lets get started!


# What is DRYML?

DRYML is a template language for Ruby on Rails that you can use in place of Rails' built in ERB templates. It is part of the larger Hobo project, but will eventually be made available as a separate plugin. DRYML was created in response to the observation that the vast majority of Rails development time seems to be spent in the view-layer. Rails' models are beautifully declarative, the controllers can be made so pretty easily (witness the many and various "result controller" plugins), but the views, ah the views...

Given that so much of the user-interaction we encounter on the web is so similar from one website to another, surely we don't have to code all this stuff up from low-level primitives over and over again? Please, no! Of course what we want is a nice library of ready-to-go user interface components, or widgets, which can be quickly added to our project, and easily tailored to the specifics of our application.

If you've been at this game for a while you're probably frowning about now. Re-use is a very, very thorny problem. It's one of those things that sounds straight-forward and obvious in principle, but turns out to be horribly difficult in practice. When you come to re-use something, you very often find that your new needs differ from the original ones in a way that wasn't foreseen or catered for in the design of the component. The more complex the component, the more likely it is that bending the thing to your needs will be harder than starting again from scratch. 

So the challenge is not in being able to re-use code, it is in being able to re-use code in ways that were not foreseen. The reason we created DRYML was to see if this kind of flexibility could be built into the language itself. DRYML is a tag based language that makes it trivially easy to give the defined tags a great deal of flexibility.

So DRYML is just a means to an end. The real goal is to create a library of reusable user-interface components that actually succeed in making it very quick and easy to create the view-layer of a web application. That library is also part of Hobo -- the *Rapid* tag library, but Rapid is not covered in this guide. Here we will see how DRYML provides the tools and raw materials that make a library like Rapid possible.

Not covering Rapid means that many of the examples are *not* good advice for use of DRYML in a full Hobo app. For example, in this guide you might see

    <%= h this.name %>
    
Which in an app that used Rapid would be better written `<view:name/>` or even just `<name/>` (that's a tag by the way, called `name`, not some metaprogramming trick that lets you use field names as tags). Bear that in mind while you're reading this guide. The examples are chosen to illustrate the point at hand, they are not necessarily something you want to paste right into your application.
    


# Simple page templates and ERB

In it's most basic usage, DRYML can be indistinguishable from a normal Rails template. That's because DRYML is (almost) an extension of ERB, so you can still use Ruby snippets using the `<% ... %>` notation. For example, a show-page for a blog post might look like this:

    <html>
      <head>
        <title>My Blog</title>
      </head>
      <body>
        <h1>My Famous Blog!</h1>
        <h2><%= @post.title %></h2>
        
        <div class="post-body">
          <%= @post.body %>
        </div>
      </body>
    </html>
{: .dryml}

## No ERB inside tags

DRYML's support for ERB is not *quite* the same as true ERB templates. The one thing you can't do is use ERB snippets inside a tag. To have the value of an attribute generated dynamically in ERB, you could do:

    <a href="<%= my_url %>">
    
In DRYML you would do:

    <a href="#{my_url}">
    
In rare cases, you might use an ERB snippet to output one or more entire attributes:

    <form <%= my_attributes %>>
    
We're jumping ahead here, so just skip this if it does't make sense, but to do the equivalent in DRYML, you would need your attributes to be in a hash (rather than a string), and do:

    <form merge-attrs="&my_attributes">
    
Finally, in a rare case you could even use an ERB snippet to generate the tag name itself:

    <<%= my_tag_name %>> ... </<%= my_tag_name %>>
    
To achieve that in DRYML, you could put the angle brackets in the snippet too:

    <%= "<#{my_tag_name}>" %> ... <%= "</#{my_tag_name}>" %>
    
## Where are the layouts?

Going back to the `<page>` tag at the start of this section, from a "normal Rails" perspective, you might be wondering why the boilerplate stuff like `<html>`, `<head>` and `<body>` are there. What happened to layouts? You don't tend to use layouts with DRYML, instead you would define your own tag, typically `<page>`, and call that. Using tags for layouts is much more flexible, and it moves the choice of layout out of the controller and into the view-layer, where it should be.
    
We'll see how to define a `<page>` tag in the next section.


# Defining simple tags

One of the strengths of DRYML is that defining tags is done right in the template (or in an imported tag-library) using the same XML-like syntax. This means that if you've got mark-up you want to re-use, you can simply cut-and-paste it into a tag definition.

Here's the page from the previous section, defined as a `<page>` tag simply by wrapping the mark-up in a `<def>` tag:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body>
          <h1>My Famous Blog!</h1>
          <h2><%= @post.title %></h2>
      
          <div class="post-body">
            <%= @post.body %>
          </div>
        </body>
      </html>
    </def>
{.dryml}


Now we can call that tag just as we would call any other:

    <page/>
{.dryml}

If you'd like an analogy to "normal" programming, you can think of the `<def>...</def>` as defining a method called `page`, and `<page/>` as a call to that method. In fact, DRYML is implemented by compiling to Ruby, and that is exactly what is happening.

## Parameters

We've illustrated the most basic usage of `<def>`, but out `<page>` tag is not very useful. Let's take it a step further to make it into the equivalent of a layout. First of all, we clearly need the body of the page to be different each time we call it. In DRYML we achieve this by adding *parameters* to the definition, which is accomplished with the `param` attribute. Here's the new definition:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body param/>
      </html>
    </def>
{.dryml}


Now we can call that tag providing our own body:

    <page>
      <body:>
        <h1>My Famous Blog!</h1>
        <h2><%= @post.title %></h2>
    
        <div class="post-body">
          <%= @post.body %>
        </div>
      </body:>
    </page>
{.dryml}

See how easy that was? We just added `param` to the `<body>` tag, which means our page tag now has a parameter called `body`. In the call we provide some content for that parameter. It's very important to read that call to `<page>` properly. In particular, the `<body:>` (note the trailing ':') is *not* a call to a tag, it is providing a named parameter to the call to `<page>`. We call `<body:>` a *parameter tag*. In Ruby terms you could think of the call like this:
        
    page(:body => "...my body content...")
    
Note that is not actually what the compiled Ruby looks like in this case, but it illustrates the important point that `<page>` is a call to a defined tag, whereas `<body:>` is providing a parameter to that call.
    
## Changing Parameter Names
    
To give the parameter a different name, we can provide a value to the `param` attribute:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body param="content"/>
      </html>
    </def>
{.dryml}

We would now call the tag like this:

    <page><content:> ...body content goes here... </content:></page>
    
## Multiple Parameters
    
As you would expect, we can define many parameters in a single tag. For example, here's a page with a side-bar:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body>
          <div param="content"/>
          <div param="aside" />
        </body>
      </html>
    </def>
{.dryml}

Which we could call like this:

    <page>
      <content:> ... main content here ... </content:>
      <aside:>  ... aside content here ... </aside:>
    </page>
{.dryml}

Note that when you name a parameter, DRYML automatically adds a css class of the same name to the output, so the two `<div>` tags above will be output as `<div class="content">` and `<div class="aside">` respectively.
    
## Default Parameter Content

In the examples we've seen so far, we've only put the `param` attribute on empty tags. That's not required though. If you declare a non-empty tag as a parameter, the content of that tag becomes the default when the call does not provide that parameter. This means you can easily add a parameter to any part of the template that you think the caller might want to be able to change

    <def tag="page">
      <html>
        <head>
          <title param>My Blog</title>
        </head>
        <body param>
      </html>
    </def>
{.dryml}

We've made the page title parameterised. All existing calls to `<page/>` will continue to work unchanged, but we've now got the ability to change the title on a per-page basis:

    <page>
      <title:>My VERY EXCITING Blog</title:>
      <body:>
        ... body content
      </body:>
    </page>
{.dryml}

This is a very nice feature of DRYML - whenever you're writing a tag, and you see a part that might be useful to change in some situations, just throw the `param` attribute at it and you're done.

## Nested `param` Declarations

You can nest `param` declarations inside other tags that have `param` on them. For example, there's no need to chose between a `<page>` tag that provides a single content section and one that provides an aside section as well -- a single definition can serve both purposes:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body param>
          <div param="content"/>
          <div param="aside" />
        </body>
      </html>
    </def>
{.dryml}

Here the `<body>` tag is a `param`, and so are the two `<div>` tags inside it. It can be called either like this:
    
    <page>
      <body:> ... page content goes here ... </body:>
    </page>
{.dryml}    

Or like this:

    <page>
      <content:> ... main content here ... </content:>
      <aside:>  ... aside content here ... </aside:>
    </page>
{.dryml}

An interesting question is, what happens if you give both a `<body:>` parameter and say, `<content:>`. By providing the `<body:>` parameter, you have replaced everything inside the body section, including those two parameterised `<div>` tags, so the `<body:>` you have provided will appear as normal, but the `<content:>` parameter will be silently ignored.

    
## The Default Parameter

In the situation where you only want a single parameter, you can give your tag a more compact XML-like syntax by using the special parameter name `default`:

    <def tag="page">
      <html>
        <head>
          <title>My Blog</title>
        </head>
        <body param="default"/>
      </html>
    </def>
{.dryml}

Now there is no need to give a parameter tag in the call at all - the content directly inside the `<page>` tag becomes the `default` parameter:
    
    <page> ... body content goes here -- no need for a parameter tag ... </page>
    
You might notice that the `<page>` tag is now indistinguishable from a normal HTML tag. Some find this aspect of DRYML disconcerting at first -- how can you tell what is an HTML tag and what it a defined DRYML tag? The answer is -- you can't, and that's quite deliberate. This allows you to do nice tricks like define your own smart `<form>` tag or `<a>` tag (the Rapid library does exactly that). Other tag-based template languages (e.g. Java's JSP) like to put everything in XML namespaces. The result is very cluttered views that are boring to type and hard to read. From the start we put a very high priority on making DRYML templates compact and elegant. When you're new to DRYML you might have to do a lot of looking things up, as you would with any new language or API, but things gradually become familiar and then view templates can be read and understood very easily.
{.aside}    


# The Implicit Context

In addition to the most important goal behind DRYML - creating a template language that would encourage re-use in the view-layer, a secondary goal is for templates to be concise, elegant and readable. One aspect of DRYML that helps a lot in this regard is something called the *implicit context*.

This feature was borne of a simple observation that pretty much every page in a web-app renders some kind of hierarchy of application objects. Think about a simple page in a blog - say, the permalink page for an individual post. The page as a whole can be considered a rendering of a BlogPost object. Then we have sections of the page that display different "pieces" of the the post -- the title, the date, the author's name, the body. Then we have the comments. The list of comments as a whole is also a "piece" of the BlogPost. Within that we have each of the individual comments, and the whole thing starts again: the comment title, date, author... This can carry on even further, for example some blogs are set-up so that you can comment on comments.

This structure is incredibly common, perhaps even universal, as it seems to be intrinsically tied to the way we visually parse information. DRYML's implicit context takes advantage of this fact to make templates extremely concise while remaining readable and clear. The object that you are rendering in any part of the page is known as the *context*, and every tag has access to this object through the method `this`. The controller sets up the initial context, and the templates then only have to mention where the context needs to *change*.

We'll dive straight into some examples, but first a quick general point about this guide. If you like to use the full Hobo framework, you will probably always use DRYML and the Rapid tag library together. DRYML and Rapid have grown up together, and the design of each is heavily influenced by the other. Having said that, this is the DRYML Guide, not the Rapid Guide. We won't be using any Rapid tags in this guide, because we want to document DRYML the language properly. That will possibly be a source of confusion if you're very used to working with Rapid. Just keep in mind that we're not allowed to use any Rapid tags in this guide and you'll be fine.

In order to see the implicit context in its best light, we'll start by defining a `<view>` tag, that simply renders the current context with HTML escaping. Remember the context is always available as `this`:
    
    <def tag="view"><%= h this.to_s %></def>
{.dryml}

And here's a tag for making a link to the current context. We'll assume the object will be recognised by Rails' polymorphic routing. Let's call it `<l>` (for link).

    <def tag="l"><a href="#{url_for this}" param="default"/></def>
    
Note that by defining that `<a>` tag, normal HTML `<a>` tags won't work anymore. We'll see how to fix that in a later section. Now let's use these tags in a page template. We'll stick with the comfortingly boring blog post example. In order to set the initial context, our controller action would need to do something like this:

    def show
      @this = @blog_post = BlogPost.find(params[:id])
    end
{.ruby}

The DRYML template handler looks for the `@this` instance variable for the initial context. It's quite nice to also set the more conventionally named instance variable as we've done here. Now we'll create the page, let's assume we're using a `<page>` tag along the lines of those defined above. We'll also assume that the blog post object has these fields: `title`, `published_at`, `body` and `belongs_to :author`, and that the author has a `name` field.
    
    <page>
      <content:>
        <h2><view:title/></h2>
        <div class="details">
          Published by <l:author><view:name/></l> on <view:published-at/>.
        </div>
        <div class="post-body">
          <view:body/>
        </div>
      </content:>
    </page>
{.dryml}

When you see a tag like `<view:title/>`, you don't get any prizes for guessing what will be displayed. In terms of what actually happens, you can read this as "change the context to be the `title` attribute of the current context, then call the `<view`> tag". You might like to think of that change to the context as `this = this.title` (although in fact `this` is not assignable). But really you just think of it as "view the title". Of what? Of whatever is in context, in this case the blog post.

Be careful with the two different uses of colon in DRYML. A trailing colon as in `<foo:>` indicates a parameter tag, whereas a colon joining two names as in `<view:title/>` indicates a change of context.

When the tag ends, the context is set back to what it was. In the case of `<view/>` which is a self-closing tag familiar from XML, that happens immediately. The `<l>` tag is more interesting. We set the context to be the author, so that the link goes to the right place. Inside the `<l>` that context remains in place so we just need `<view:name/>` in order to display the author's name.

## `with` and `field` attributes

The `with` attribute is a special DRYML attribute that sets the context to be the result of any Ruby expression before the tag is called. In DRYML any attribute value that starts with '&' is interpreted as a Ruby expression. Here's the same example as above using only the with attribute:

    <page>
      <content:>
        <h2><view with="@blog_post.title"/></h2>
        <div class="details">
          Published by <l with="&@blog_post.author"><view with="&this.name"/></l>
          on <view with="&@blog_post.published-at"/>.
        </div>
        <div class="post-body">
          <view with="&@blog_post.body"/>
        </div>
      </content:>
    </page>
{.dryml}

Note that we could have used `&this.title` instead of `&@blog_post.title`.

The `field` attribute makes things more concise by taking advantage of a common pattern. When changing the context, we very often want to change to some attribute of the current context. `field="x"` is a shorthand for `with="&this.x"` (actually it's not quite the same, using the `field` version also sets `this_parent` and `this_field`, whereas `with` does not. This is discussed later in more detail).

The same template again, this time using `field`:

    <page>
      <content:>
        <h2><view field="title"/></h2>
        <div class="details">
          Published by <l field="author"><view field="name"/></l> on <view field="published-at"/>.
        </div>
        <div class="post-body">
          <view field="body"/>
        </div>
      </content:>
    </page>
{.dryml}

If you compare that example to the first one, you should notice that the `:` syntax is just a shorthand for the `field` attribute. i.e. `<view field="name">` and `<view:name>` are equivalent.
    
# Tag attributes

As we've seen, DRYML provides parameters as a mechanism for customising the markup that is output by a tag. Sometimes we want to provide other kinds of values to control the behaviour of a tag: URLs, filenames or even ruby values like hashes and arrays. For this situation, DRYML lets you define tag attributes.

As a simple example, say your application has a bunch of help files in `public/help`, and you have links to them scattered around your views. Here's a tag you could define:

    <def tag="help-link" attrs="file">
      <a class="help" href="#{base_url}/help/#{file}.html" param="default"/>
    </def>
{: .dryml}

`<def>` takes a special attribute `attrs`. Use this to declare a list (separated by commas) of attributes, much as you declare arguments to a method in Ruby. In this definition we contstruct the URL from the `base_url` helper and `file`, which is a local variable. You should think of `file` as an ordinary argument to a method. Just like arguments in Ruby, it becomes a local variable inside the tag definition. Notice the use of the Ruby string interpolation syntax (`#{...}`) inside that `href`. You can use that syntax in any attribute in DRYML.

The call to this tag would look like:

    <help-link file="intro">Introductory Help</help-link>
{: .dryml}

The regular XML-link arttribute syntax -- `file="intro"` -- will be pass a string value to the attribute. DRYML also allows you to pass any Ruby value. When the attribute value starts with `&`, the rest of the attribute is interpretted as a Ruby expression. For example you could use this syntax to pass `true` and `false` values:

    <help-link file="intro" new-window="&true">Introductory Help</help-link>
    <help-link file="intro" new-window="&false">Introductory Help</help-link>
{: .dryml}

And we could add that `new-window` attribute to the definition like this:

    <def tag="help-link" attrs="file, new-window">
      <a class="help" href="#{base_url}/help/#{file}.html" target="#{new_window ? '_blank' : '_self' }" param="default"/>
    </def>
{: .dryml}

An important point to notice there is that the markup-friendly dash in the `new-window` attribute, became a Ruby-friendly underscore (`new_window`) in the Ruby expression.

Using the `&`, you can pass any value you like -- arrays, hashes, active-record objects...

In the case of boolean values like the one used in the above example, there is a nicer syntax that can be used in the call...


## Flag attributes

That `new-window` attribute shown in the previous section is simple switch - on or off. DRYML lets you ommit the value of the attribute, giving a flag-like syntax:

    <help-link file="intro" new-window>Introductory Help</help-link>
    <help-link file="intro">Introductory Help</help-link>
{: .dryml}

Ommitting the attribute value is equivalent to giving `"&true"` as the value. In the second exampe the attribute is ommitted entirely, meaning the value will be `nil` which is false in Ruby so it works as expected.


## `attributes` and `all_attributes` locals

Inside a tag definition two hashes are available in local variable: `attributes` contains all the attributes that *were not declared* in the `attrs` list of the `def`; `all_attributes` contains every attribute, including the declared ones.


## Merging Attributes

In a tag definition, you can use the `merge-attrs` attribute to take any 'extra' attributes that the caller passed in, and add them to a tag of your choosing inside your definition. Let's backtrack a bit and see why you might want to do that.

Here's a simple tag definition - it's similar to a tag defined in the Hobo Cookbook app:

    <def tag="markdown-help">
      <a href="http://daringfireball.net/projects/markdown/syntax" param="default"/>
    </def>
{: .dryml}

You would use it like this:

    Add formatting to your recipe using <markdown-help>markdown</markdown-help>
{: .dryml}

Suppose you wanted to give the caller the ability to chose the `target` for the link. You could extend the definition like this:

    <def tag="markdown-help" attrs="target">
      <a href="http://daringfireball.net/projects/markdown/syntax" target="&target" param="default"/>
    </def>
{: .dryml}

Now we can call the tag like this:

    Add formatting to your recipe using <markdown-help target="_blank">markdown</markdown-help>
{: .dryml}

OK, but maybe the caller wants to add a css class, or a javascript `onclick` attribute, or any one of a dozen potential HTML attributes. This approach is not going to scale. That's where `merge-attrs` comes in. As we've seen, any a

As mentioned, DRYML keeps track of all the attributes that were passed to a tag, even if they were not declared in the `attrs` list of the tag definition. They are available in two hashes: `attributes` (that has only undeclared attributes) and `all_attributes` (that has all of them), but in normal usage you don't need to access those variable. To add all of the undelcared attribtues to a tag inside your definition, just add the `merge-attrs` attribute, like this:

    <def tag="markdown-help">
      <a href="http://daringfireball.net/projects/markdown/syntax" merge-attrs param="default"/>
    </def>
{: .dryml}

Note that the `merge` attribute is another way of merging attributes. Declaring `merge` is a shorthand for declaraing both `merge-attrs` and `merge-params` (which we'll cover later).

# Repeated and optional content

As you would expect from any template language, DRYML has the facility to repeat sections on content, and to optionally render or not render given sections according to your applications data. DRYML provides two alternative syntaxes, much as Ruby does (e.g. Ruby has the block `if` and the one-line suffix version of `if`).

## Conditionals - if and unless

DRYML provides `if` and `unless` both as tags, which come from the core tag library, and are just ordinary tag definitions, and as attributes, which are part of the language:

The tag version:

    <if test="&logged_in?"><p>Welcome back</p></if>
{: .dryml}

The attribute version:

    <p if="&logged_in?">Welcome back</p>
{: .dryml}
    
Important note! The test if performed (in Ruby terms) like this:

    if (...your test expression...).blank?
{: .ruby}

Got that? Blankiness not thruthiness (`blank?` comes from ActiveSupport by the way -- Rails' mixed bag of core-Ruby extensions). So for example, in DRYML

    <if test="&current_user.comments">
{: .dryml}

is a test to see if there are any comments -- empty collections are considered blank. We are of the opinion that Matz made a fantastic choice for Ruby when he followed the Lisp / Smalltalk approach to truth values, but that view templates are a special case, and testing for blankness is more often what you want.

Can we skip unless? You get the picture, right?


## Repitition, repitition, repitition, repitition, repitition

Some things need to be repeated. Some things, like the word 'repitition' in a sub-title, don't. And then they are. Life can be like that. It doesn't matter. For repition DRYML gives us the `<repeat>` tag (from the core tag library) and the `repeat` attribute.
    
The tag version:
    
    <repeat with="&current_user.new_messages"> <h3><%= h this.subject %></h3> </repeat>
{: .dryml}

The attribute version:

    <h3 repeat="&current_user.new_messages"><%= h this.subject %></h3>
{: .dryml}

Notice that as well as the content being repeated, the implicit-context is set to each item in the collection in turn.


### even/odd classes

It's a common need to want alternating styles for items in a collection - e.g. striped table rows. Both the repeat attribute and the repeat tag set a scoped variable `scope.even_odd` which will be alternately 'even' then 'odd', so for example you could do:

    <h3 repeat="&current_user.new_messages" class="#{scope.even_odd}"><%= h this.subject %></h3>
{: .dryml}

That example illustrates another important point -- any Ruby code in attributes is evaluated *inside* the repeat. In other words, the `repeat` attribute behaves the same as wrapping the tag in a `<repeat>` tag.
    
    
### `first_item?` and `last_item?` helpers

Another common need is to give special treatment to the first and last items in a collection. The `first_item?` and `last_item?` helpers can be used to find out when these items come up, e.g we could capitalise the first item:

    <h3 repeat="&current_user.new_messages"><%= h(first_item? ? this.subject.upcase : this.subject) %></h3>
{: .dryml}


### Repeating over hashes

If you give a hash as the value to repeat over, DRYML will iterate over each key/value pair, with the value available as `this` (i.e. the implicit-context) and the key available as `this_key`. This is particularly useful for grouping things in combination with the `group_by` method:

    <div repeat="&current_user.new_messages.group_by(&:sender)">
      <h2>Messages from <%= h this_key %></h2>
        <ul>
          <li repeat><%= h this.subject %></li>
        </ul>
      <h2>
    </div>
{: .dryml}

That example has given a sneak preview of another point - using if/unless/repeat with the implicit context. We'll get to that in a minute.


## Using the implicit context

If you don't specify the test of a conditional, or the collection to repeat over, the implicit context is used. This allows for a few nice short-hands. For example, this is a common pattern for rendering collections:

    <if:comments>
      <h3>Comments</h3>
      <ul>
        <li repeat> ... </li>
      </ul>
    </if>
{: .dryml}

We're switching the context on the `<if>` tag to be `this.comments`, which has two effects. Firstly the comments collection is used as the test for the `if`, so the whole section including the heading will be ommitted if the collection is empty (remember that `if` tests for blankness, and empty collections are considered blank). Secondly, the context is switched to be the comments collection, so that when we come to repeat the `<li>` tag, all we need to say is `repeat`.


### One last shorthand - attributes of `this`

The attribute versions of `if`/`unless` and `repeat` support a useful shortcut for accessing attributes or methods of the implicit context. If you give a literal string attribute--that is, an attribute that does not start with `&`--this is interpretted as the name of a method on `this`. For example:

    <li repeat="comments"/>
{: .dryml}
 
is equivalent to

    <li repeat="&this.comments"/>
{: .dryml}
    
Similarly

    <p if="sticky?">This post has been marked 'sticky'</p>
{: .dryml}


is equivalent to

    <p if="this.sticky?">This post has been marked 'sticky'</p>
{: .dryml}

    
It is a bit inconsistent that these shortcuts do not work with the tag versions of `<if>`, `<unless>` and `<repeat>`. This may be remedied in a future version of DRYML.
    

# Psuedo-parameters - `before`, `after`, `append`, `prepend`, and `replace`

For every parameter you define in a tag, there are five "pseduo parameters" created as well. Four allow you to insert extra content without replacing existing content, and one lets you replace or remove a parameter entirely.

To help illustrate these, here's a very simple `<page>` tag:
    
    <def tag="page">
      <body>
        <h1 param="heading"><%= h @this.to_s %></h1>
        <div param="content"></div>
      </body>
    </def>
{: .dryml}

We've assumed that `@this.to_s` will give us the name of the object that this page is presenting.


## Inserting extra content

The outout of the heading would look something like:

    <h1 class="heading">Welcome to my new blog</h1>
    
Psuedo parameters give us the ability to insert extra context in four places, marked here as `(A)`, `(B)`, `(C)` and `(D)`:

    (A)<h1 class="heading">(B)Welcome to my new blog(C)</h1>(D)
    
The parameters are:

    - `(A)` -- `<before-heading:>`
    - `(B)` -- `<prepend-heading:>`
    - `(C)` -- `<append-heading:>`
    - `(D)` -- `<after-heading:>`
    
So, for example, suppose we want to add the name of the blog to the heading:

    <h1 class="heading">Welcome to my new blog -- The Hobo Blog</h1>
{: .dryml}


To achieve that on one page, we could call the `<page>` tag like this:
    
    <page>
      <append-heading:> -- The Hobo Blog</append-heading:>
      <body:>
        ...
      </body>
    </page>
{: .dryml}

Or we could go a step further and create a new page tag that added that suffix automatically. We could then use that new page tag for an entire section of our site:

    <def tag="blog-page">
      <page>
        <append-heading:> -- The Hobo Blog</append-heading:>
        <body: param></body>
      </page>
    </def>
{: .dryml}
    
(Note: we have explicitly made sure that the `<body:>` parameter is still available. There is a better way of achieving this using `merge-params` or `merge`, which are covered later.)


## Replacing a parameter entirely

So far, we've seen how the parameter mechanism allows us to change the attributes and content of a tag, but what if we wanted to remove the tag entirely? We might want a page that has no `<h1>` tag at all, or has `h2` instead. For that situation we can use "replace parameters". Here's a page with an `<h2>`  instead of an `<h1>`:
    
    <page>
      <heading: replace><h2>My Awesome Page</h2></heading:>
    </page>
{: .dryml}
    
And here's one with no heading at all:

    <page>
      <heading: replace/>
    </page>
{: .dryml}
    
There is a nice shorthand for the second case. For exaery parameter, your tag also supports a special `without` attribute. This is exactly equivalent to the previous example, but much more readable:

    <page without-heading/>
{: .dryml}
    
Note: to make things more consistent, `<heading: replace>` may become `<replace-heading:>` in the future.
    
## Current Limitation

Due to a limitation of the current DRYML implementation, you cannot use both `before` and `after` on the same parameter. You can achieve the same effect as follow (this technique is covered properly later in the section on wrapping content):

    <heading: replace>
      ... before content ...
      <heading restore>
      ... after content ...
    </heading:>
{: .dryml}


# Still to write
 
 - nested parameters
 
 - extending tags and merging params/attributes
 
 - aliasing tags
 
 - polymorphic tags
 
 - wrapping - restore and param-content
 
 - special local variables: `attributes`, `all_attributes`, `parameters` and `all_parameters`
 
 - Variables - set and set-scoped
 
 - Taglibs
 
 - Special Methods: `this_field`, `this_parent` (OTHERS?)
 
 - Current limitations and other gotchas
 
 