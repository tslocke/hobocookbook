Generators -- manual/generators/setup\_wizard.markdown
{: .document-title}


## Usage

    

    rails generate hobo:setup_wizard [options]


## Options

    

        [--wizard]                                       # Ask instead using options
                                                         # Default: true
        [--user-resource-name=USER_RESOURCE_NAME]        # User Resource Name
                                                         # Default: user
        [--migration-migrate]                            # Generate migration and migrate
                                                         # Default: true
        [--fixtures]                                     # Add the fixture option to the test framework
                                                         # Default: true
    -i, [--invite-only]                                  # Add features for an invite only website
        [--front-controller-name=FRONT_CONTROLLER_NAME]  # Front Controller Name
                                                         # Default: front
        [--activation-email]                             # Send an email to activate the account
        [--git-repo]                                     # Create the git repository with the initial commit
        [--add-admin-subsite]                            # Add an Admin Subsite
        [--fixture-replacement=FIXTURE_REPLACEMENT]      # Use a specific fixture replacement
        [--gitignore-auto-generated-files]               # Add the auto-generated files to .gitignore
                                                         # Default: true
        [--admin-subsite-name=ADMIN_SUBSITE_NAME]        # Admin Subsite Name
                                                         # Default: admin
        [--default-locale=DEFAULT_LOCALE]                # Sets the default locale
        [--private-site]                                 # Make the site unaccessible to non-members
        [--dryml-only-templates]                         # The application uses only dryml templates
        [--main-title]                                   # Shows the main title
                                                         # Default: true
        [--update]                                       # Run bundle update to install the missing gems
    -t, [--test-framework=TEST_FRAMEWORK]                # Use a specific test framework
                                                         # Default: test_unit
        [--locales=one two three]                        # Choose the locales
                                                         # Default: en
        [--migration-generate]                           # Generate migration only


## Runtime options

    

    -f, [--force]    # Overwrite files that already exist
    -q, [--quiet]    # Supress status output
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      This wizard is used by bin/hobo to configure a new
      created application. You can use it directly in order
      to overwrite any file of the original installation.
