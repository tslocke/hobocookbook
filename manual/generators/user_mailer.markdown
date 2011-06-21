Generators -- user\_mailer
{: .document-title}


## Usage

    

  rails generate hobo:user_mailer [NAME=user] [options]


## Options

    

  -i, [--invite-only]          # Add features for an invite only website
  -t, [--test-framework=NAME]  # Test framework to be invoked
                               # Default: test_unit
      [--activation-email]     # Send an email to activate the account


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    

    This generator is used by the user_resource generator to generate user_mailer.rb.
