Generators -- user\_controller
{: .document-title}


## Usage

    

  rails generate hobo:user_controller [NAME=users] [options]


## Options

    

  -i, [--invite-only]          # Add features for an invite only website
      [--helpers]              # Generates helper files
                               # Default: true
  -t, [--test-framework=NAME]  # Test framework to be invoked
                               # Default: test_unit


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## USAGE

    

    This generator is used by the user_resource generator to generate
    app/controllers/users_controller.rb
