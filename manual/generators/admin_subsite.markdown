Generators -- admin\_subsite
{: .document-title}


## Usage

    

  rails generate hobo:admin_subsite [NAME=admin] [options]


## Options

    

      [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                 # Default: user
  -i, [--invite-only]                            # Add features for an invite only website
  -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                 # Default: test_unit
      [--make-front-site]                        # Rename application.dryml to front_site.dryml


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    

    Create hobo files for admin_subsite generator.
