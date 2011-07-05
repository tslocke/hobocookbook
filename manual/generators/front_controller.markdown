Generators -- front\_controller
{: .document-title}


## Usage

    

  rails generate hobo:front_controller [NAME=front] [options]


## Options

    

      [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                 # Default: user
  -i, [--invite-only]                            # Add features for an invite only website
      [--helpers]                                # Generates helper files
                                                 # Default: true
      [--add-routes]                             # Modify config/routes.rb to support the front controller
                                                 # Default: true
  -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                 # Default: test_unit
  -d, [--delete-index]                           # Delete public/index.html
                                                 # Default: true


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    


    The hobo_front_controller generator creates a basic 'front
    controller' and related views to get your app development kick started.

    It takes a single argument -- the name of the controller

    The front controller provides a simple front-page, ready to be
    customized, and a search page.


