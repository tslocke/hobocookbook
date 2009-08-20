View Hints
{: .document-title}

One of the main attractions of Hobo is its ability to give you a pretty decent starting point for you app's UI, entirely automatically based on information extracted from your models and controllers. The more information available to Hobo, the better job it can do, but some such information doesn't properly belong in either the model or the controller. For example, we might want to declare that a particular field should have a different name in the UI than in the model layer. View-hints are the home for these kinds of declarations.


Contents
{: .contents-heading}

- contents
{:toc}

# Introduction

View-hints are added to a Hobo application by defining classes, one for each model, that extend `Hobo::ViewHints`. Here's an example - `app/viewhints/answer_hints.rb` from the Hobo Cookbook app:

    class AnswerHints < Hobo::ViewHints

      field_names :body => "", :recipe => "See recipe"
  
      field_help  :recipe => "Enter keywords from the name of a recipe"

    end
{.ruby}

As you can see, the view-hint class contains some simple declarations that pertain to a single model - the `Answer` model in this case. That's really all there is to a view-hints class. If you think of the class as little more than a YAML file with some configuration information in it, you won't be far wrong. In fact we could have used YAML files for view-hints, but using Ruby instead makes things more powerful for the metaprogrammers out there who want to explore new territory. In the normal course of events, these classes will not contain anything other than the declarations described in this chapter.

In that example we made three declarations about the user interface that we desire:

 - The `body` field does not need a label (i.e. it's name is blank).

 - The `recipe` field should be labelled "See recipe"
 
 - The `recipe` field should be displayed with the help text "Enter keywords from the name of a recipe"
 
What do these declarations do? By themselves, nothing. They are just information, metadata if you like, that we have provided about a model. The information can be retrieved using the view-hints API, for example (using the Rails console).

    >> Answer.view_hints.field_name :recipe 
    => "See recipe"
    >> Answer.view_hints.field_help[:recipe]
    => "Enter keywords from the name of a recipe"
{.ruby}

This API is used internally in Hobo, for example in the Rapid tag library, to create a user interface according to your declarations. That's really all there is to it.

At present view-hints are fairly new to Hobo. They will be put to a lot greater use as Hobo develops.

It's important to note that the view-hints mechanism is entirely optional, and may not be appropriate for all applications (especially larger applications). Everything you can do with view-hints can be done with much more flexibility by defining DRYML tags and page templates. What view-hints give you, is a way to achieve common UI customisations very quickly and easily.

# Defining hints

As mentioned, the hints are defined in `ViewHints` classes. There is one per model, and they live in `app/viewhints`. The `hobo_model_generator` will create blank view-hints classes as a starting point.

At present, there are only four kinds of hints you can give about your models:

 - The model name -- in case you want this to differ from the actual class name
 - Field names -- in case you want any of these to differ from the database column names
 - Field help -- some simple explanatory text for each field in a model
 - Child relationships -- allows you to arrange your models in a hierarchy appropriate for the user interface.
 
## Model name
 
To declare a custom model name:

    class BlogPostHints < Hobo::ViewHints

      model_name "Post"

    end
{.ruby}

NOTE: At the time of writing, support for the `model_name` declaration in Hobo Rapid is partial. The underlying class name may still be used in places.


## Field names

To declare one or more custom field names:

    class UserHints < Hobo::ViewHints

      field_names :username => "Name", :details => "Profile"

    end
{.ruby}

If you give an empty string as the name, the Rapid form generators will arrange the form appropriately, with no label for that field.


## Field help

To declare help text for one or more fields:

    class AnswerHints < Hobo::ViewHints

      field_help :recipe => "Enter keywords from the name of a recipe", :subject => "Provide a ..."

    end
{.ruby}

Rapid will include the help text next to each field in the forms that it generates.


## Child relationships

Many web applications arrange the information they present in a hierarchy. By declaring a hierarchy using the `children` declaration, Hobo can give you a much better default user interface.

At present, the `children` declaration only influences Rapid's show-page -- it governs the display of collections of `<card>` tags embedded in the show-page. If you declare a single child collection, e.g.:
  
    class UserHints < Hobo::ViewHints
  
      children :recipes
    
    end
{.ruby}
  
The a collection of the user's recipes will be added to the main content of `users/show`. 

You can declare additional child relationships. The order is significant, with the first in the list being the "primary collection". For example:

    class UserHints < Hobo::ViewHints
  
      children :recipes, :questions, :answers
    
    end
{.ruby}

With this declaration, the user's show-page will be given an aside section (sidebar), in which cards for the `questions` and `answers` collections are displayed.


# The API

The view-hints API is used internally by Hobo Rapid. You may not ever need to use it yourself. For completeness it is documented here.

The view-hints for any model can be access using the `view_hints` method:

    MyModel.view_hints
{.ruby}

That will return the view-hints class from which the hints can be accessed. Each of the declaration methods can be called without arguments to retrieve the declared values. e.g.

    >> BlogPost.view_hints.model_name
    => "Post"


## Helpers

The following view helpers are defined to simplify access to view-hints information during rendering:

 - `this_field_name` -- returns the view-hints modified name of the field currently referenced by DRYML's `this_field`. That is, the field of the current context
 
 - `this_field_help` -- returns the help text associated with the field currently in context.


