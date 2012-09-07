Generators -- manual/generators/setup\_wizard.markdown
{: .document-title}


## Usage

    

    rails generate hobo:setup_wizard [options]


## Options

    

        [--admin-subsite-name=ADMIN_SUBSITE_NAME]        # Admin Subsite Name
                                                         # Default: admin
    -t, [--test-framework=TEST_FRAMEWORK]                # Use a specific test framework
                                                         # Default: test_unit
        [--gitignore-auto-generated-files]               # Add the auto-generated files to .gitignore
                                                         # Default: true
        [--invite-only]                                  # Require invitation to join site
        [--main-title]                                   # Shows the main title
                                                         # Default: true
        [--default-locale=DEFAULT_LOCALE]                # Sets the default locale
        [--private-site]                                 # Make the site unaccessible to non-members
        [--fixture-replacement=FIXTURE_REPLACEMENT]      # Use a specific fixture replacement
        [--dryml-only-templates]                         # The application uses only dryml templates
        [--wizard]                                       # Ask instead using options
                                                         # Default: true
        [--migration-generate]                           # Generate migration only
        [--locales=one two three]                        # Choose the locales
                                                         # Default: en
        [--front-controller-name=FRONT_CONTROLLER_NAME]  # Front Controller Name
                                                         # Default: front
        [--user-resource-name=USER_RESOURCE_NAME]        # User Resource Name
                                                         # Default: user
        [--migration-migrate]                            # Generate migration and migrate
                                                         # Default: true
        [--fixtures]                                     # Add the fixture option to the test framework
                                                         # Default: true
        [--add-admin-subsite]                            # Add an Admin Subsite
        [--update]                                       # Run bundle update to install the missing gems
        [--activation-email]                             # Send an email to activate the account
        [--git-repo]                                     # Create the git repository with the initial commit


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      This wizard is used by bin/hobo to configure a new
      created application. You can use it directly in order
      to overwrite any file of the original installation.
