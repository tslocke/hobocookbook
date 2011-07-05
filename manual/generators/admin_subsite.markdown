Generators -- admin\_subsite
{: .document-title}


## Usage

    

  rails generate hobo:admin_subsite [NAME=admin] [options]


## Options

    

      --make-front-site                          # Rename application.dryml to front_site.dryml
      [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                 # Default: user
  -i, [--invite-only]                            # Add features for an invite only website
  -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                 # Default: test_unit


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    


    Creates a subsite, a namespaced section of your application.

    Controllers for the subsite are created in
    app/controllers/<subsite_name>/ and views are also in their own
    subdirectory.   This allows you to have two different controllers
    and two different sets of views for the same model.

    The subsite will use app/views/taglibs/<subsite_name>_site.dryml
    as well as app/views/taglibs/application.dryml.  This allows you
    to customize the look and feel of a portion of your site.  The
    remaining views of your application that are not under a subsite
    load both application.dryml and front_site.dryml.

    It is thus recommended that you ensure that
    <subsite_name>_site.dryml and application.dryml do not repeat
    code, such as the inclusion of rapid or the setting of the theme.
    One easy way of ensuring this is to use the --make-front-site
    option.  If you have already accounted for this, use
    --make-front-site=false.

    The difference between hobo:admin_site and hobo:subsite is that
    hobo:admin_site limits the subsite to use by administrators only.

