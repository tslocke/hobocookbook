Generators -- manual/generators/front\_controller.markdown
{: .document-title}


## Usage

    

    rails generate hobo:front_controller [NAME=front] [options]


## Options

    

        [--helpers]                                # Generates helper files
                                                   # Default: true
    -i, [--invite-only]                            # Add features for an invite only website
        [--add-routes]                             # Modify config/routes.rb to support the front controller
                                                   # Default: true
    -d, [--delete-index]                           # Delete public/index.html
                                                   # Default: true
        [--skip-namespace]                         # Skip namespace (affects only isolated applications)
        [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                   # Default: user
    -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                   # Default: test_unit
        [--old-style-hash]                         # Force using old style hash (:foo => 'bar') on Ruby >= 1.9


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Suppress status output


## Description

    


      The hobo_front_controller generator creates a basic 'front
      controller' and related views to get your app development kick started.

      It takes a single argument -- the name of the controller

      The front controller provides a simple front-page, ready to be
      customized, and a search page.


