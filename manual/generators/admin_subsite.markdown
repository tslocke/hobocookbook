Generators -- manual/generators/admin\_subsite.markdown
{: .document-title}


## Usage

    

    rails generate hobo:admin_subsite [NAME=admin] [options]


## Options

    

    -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                   # Default: test_unit
        [--skip-namespace]                         # Skip namespace (affects only isolated applications)
    -i, [--invite-only]                            # Add features for an invite only website
        [--old-style-hash]                         # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                   # Default: user


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    


      Creates a subsite, a namespaced section of your application.

      Controllers for the subsite are created in
      app/controllers/<subsite_name>/ and views are also in their own
      subdirectory.   This allows you to have two different controllers
      and two different sets of views for the same model.

      The subsite will use app/views/taglibs/<subsite_name>_site.dryml
      for common tags. The assets that the subsite will load are
      specified in app/assets/javascripts/<subsite_name>.js and
      app/assets/stylesheets/<subsite_name>.[s]css

      The difference between hobo:admin_site and hobo:subsite is that
      hobo:admin_site limits the subsite to use by administrators only.

