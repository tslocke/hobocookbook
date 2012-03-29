Generators -- manual/generators/setup\_wizard.markdown
{: .document-title}


## Usage

    

    rails generate hobo:setup_wizard [options]


## Options

    

        [--gitignore-auto-generated-files]               # Add the auto-generated files to .gitignore
                                                         # Default: true
        [--default-locale=DEFAULT_LOCALE]                # Sets the default locale
        [--admin-subsite-name=ADMIN_SUBSITE_NAME]        # Admin Subsite Name
                                                         # Default: admin
        [--fixture-replacement=FIXTURE_REPLACEMENT]      # Use a specific fixture replacement
        [--private-site]                                 # Make the site unaccessible to non-members
        [--locales=one two three]                        # Choose the locales
                                                         # Default: en
        [--main-title]                                   # Shows the main title
                                                         # Default: true
        [--migration-generate]                           # Generate migration only
        [--wizard]                                       # Ask instead using options
                                                         # Default: true
        [--user-resource-name=USER_RESOURCE_NAME]        # User Resource Name
                                                         # Default: user
        [--migration-migrate]                            # Generate migration and migrate
                                                         # Default: true
        [--fixtures]                                     # Add the fixture option to the test framework
                                                         # Default: true
    -t, [--test-framework=TEST_FRAMEWORK]                # Use a specific test framework
                                                         # Default: test_unit
    -i, [--invite-only]                                  # Add features for an invite only website
        [--front-controller-name=FRONT_CONTROLLER_NAME]  # Front Controller Name
                                                         # Default: front
        [--activation-email]                             # Send an email to activate the account
        [--git-repo]                                     # Create the git repository with the initial commit
        [--update]                                       # Run bundle update to install the missing gems
        [--dryml-only-templates]                         # The application uses only dryml templates
        [--add-admin-subsite]                            # Add an Admin Subsite


## Runtime options

    

    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Supress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist


## Description

    

      This wizard is used by bin/hobo to configure a new
      created application. You can use it directly in order
      to overwrite any file of the original installation.
