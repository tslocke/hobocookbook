Generators -- manual/generators/setup\_wizard.markdown
{: .document-title}


## Usage

    

    rails generate hobo:setup_wizard [options]


## Options

    

        [--migration-generate]                           # Generate migration only
        [--main-title]                                   # Shows the main title
                                                         # Default: true
        [--admin-subsite-name=ADMIN_SUBSITE_NAME]        # Admin Subsite Name
                                                         # Default: admin
        [--user-resource-name=USER_RESOURCE_NAME]        # User Resource Name
                                                         # Default: user
        [--default-locale=DEFAULT_LOCALE]                # Sets the default locale
        [--migration-migrate]                            # Generate migration and migrate
                                                         # Default: true
        [--wizard]                                       # Ask instead using options
                                                         # Default: true
        [--fixture-replacement=FIXTURE_REPLACEMENT]      # Use a specific fixture replacement
        [--fixtures]                                     # Add the fixture option to the test framework
                                                         # Default: true
        [--admin-theme=ADMIN_THEME]                      # Admin Theme
                                                         # Default: clean
        [--activation-email]                             # Send an email to activate the account
        [--dryml-only-templates]                         # The application uses only dryml templates
        [--git-repo]                                     # Create the git repository with the initial commit
        [--front-controller-name=FRONT_CONTROLLER_NAME]  # Front Controller Name
                                                         # Default: front
        [--locales=one two three]                        # Choose the locales
                                                         # Default: en
        [--admin-ui-theme=ADMIN_UI_THEME]                # Admin jQuery-UI Theme
                                                         # Default: redmond
        [--gitignore-auto-generated-files]               # Add the auto-generated files to .gitignore
                                                         # Default: true
        [--front-theme=FRONT_THEME]                      # Front Theme
                                                         # Default: clean
        [--invite-only]                                  # Require invitation to join site
        [--front-ui-theme=FRONT_UI_THEME]                # Front jQuery-UI Theme
                                                         # Default: redmond
        [--private-site]                                 # Make the site unaccessible to non-members
        [--update]                                       # Run bundle update to install the missing gems
    -t, [--test-framework=TEST_FRAMEWORK]                # Use a specific test framework
                                                         # Default: test_unit
        [--add-admin-subsite]                            # Add an Admin Subsite


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -q, [--quiet]    # Suppress status output


## Description

    

      This wizard is used by bin/hobo to configure a new
      created application. You can use it directly in order
      to overwrite any file of the original installation.
