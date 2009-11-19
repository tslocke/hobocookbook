# Generators

These are the manual pages for the Hobo generators.  They do not
provide any information beyond what is available on the help pages.
For instance:

    $ ruby script/generate hobo --help

## Contents

 * [hobo](/manual/generators/hobo) &mdash; hooks Hobo into your app
 * [hobo\_rapid](/manual/generators/hobo_rapid) &mdash; adds the Rapid library
 * [hobo\_model](/manual/generators/hobo_model) &mdash; generates a Hobo::Model
 * [hobo\_model\_controller](/manual/generators/hobo_controller) &mdash;  model, controller and views
 * [hobo\_model\_resource](/manual/generators/hobo_model_resource) &mdash; model, controller, views & tests
 * [hobo\_front\_controller](/manual/generators/hobo_front_controller) &mdash; front page controller
 * [hobo\_user\_model](/manual/generators/hobo_user_model) &mdash; User model
 * [hobo\_user\_controller](/manual/generators/hobo_user_controller) &mdash; User controller and views
 * [hobo\_subsite](/manual/generators/hobo_subsite) &mdash; subsite system
 * [hobofield\_model](/manual/generators/hobofield_model) &mdash; generates a HoboFields based model
 * [hobo\_migration](/manual/generators/hobo_migration) &mdash; generates a migrations.

## Comments

[hobofield\_model](hobofield_model) does not require the Hobo gem.  If you are using the full Hobo system, [hobo\_model](generators/hobo_model) is probably more appropriate.

There is more low-level documentation for Hobo migrations available in the [Hobo Fields: Migration Generator](hobofields/migration_generator) documentation.

The `hobo` executable runs the `rails` executable and then the following generators.

    ruby script/generate hobo --add-gem --add-routes
    ruby script/generate hobo_rapid --import-tags #{invite_only}
    ruby script/generate hobo_user_model #{user_model} #{invite_only}
    ruby script/generate hobo_user_controller #{user_model} #{invite_only}
    ruby script/generate hobo_front_controller front --delete-index --add-routes #{invite_only}

The `rake hobo:run_standard_generators` task runs:

      ruby script/generate hobo --add-routes && \
      ruby script/generate hobo_rapid --import-tags && \
      ruby script/generate hobo_user_model user && \
      ruby script/generate hobo_user_controller user && \
      ruby script/generate hobo_front_controller front --delete-index --add-routes
