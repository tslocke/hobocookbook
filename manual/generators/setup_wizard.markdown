Generators -- setup\_wizard
{: .document-title}


## Usage

    

    rails generate hobo:setup_wizard [options]


## Options

    

        [--dryml-only-templates]                         # The application uses only dryml templates
        [--admin-subsite-name=ADMIN_SUBSITE_NAME]        # Admin Subsite Name
                                                         # Default: admin
        [--gitignore-auto-generated-files]               # Add the auto-generated files to .gitignore
                                                         # Default: true
    -t, [--test-framework=TEST_FRAMEWORK]                # Use a specific test framework
                                                         # Default: test_unit
        [--make-front-site]                              # Rename application.dryml to front_site.dryml
                                                         # Default: true
        [--main-title]                                   # Shows the main title
                                                         # Default: true
        [--private-site]                                 # Make the site unaccessible to non-members
        [--wizard]                                       # Ask instead using options
                                                         # Default: true
        [--migration-generate]                           # Generate migration only
        [--front-controller-name=FRONT_CONTROLLER_NAME]  # Front Controller Name
                                                         # Default: front
        [--user-resource-name=USER_RESOURCE_NAME]        # User Resource Name
                                                         # Default: user
        [--fixture-replacement=FIXTURE_REPLACEMENT]      # Use a specific fixture replacement
        [--default-locale=DEFAULT_LOCALE]                # Sets the default locale
        [--migration-migrate]                            # Generate migration and migrate
                                                         # Default: true
        [--fixtures]                                     # Add the fixture option to the test framework
                                                         # Default: true
        [--add-admin-subsite]                            # Add an Admin Subsite
        [--update]                                       # Run bundle update to install the missing gems
        [--activation-email]                             # Send an email to activate the account
        [--git-repo]                                     # Create the git repository with the initial commit
        [--locales=one two three]                        # Choose the locales
                                                         # Default: en
    -i, [--invite-only]                                  # Add features for an invite only website


## Runtime options

    

    -f, [--force]    # Overwrite files that already exist
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Supress status output


## Description

    

      This wizard is used by bin/hobo to configure a new
      created application. You can use it directly in order
      to overwrite any file of the original installation.
