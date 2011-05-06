Generators -- user\_model
{: .document-title}


## Usage

    

  rails generate hobo:user_model [NAME=user] [options]


## Options

    

      [--timestamps]                             # Indicates when to generate timestamps
  -i, [--invite-only]                            # Add features for an invite only website
      [--activation-email]                       # Send an email to activate the account
      [--admin-subsite-name=ADMIN_SUBSITE_NAME]  # Admin Subsite Name
                                                 # Default: admin


## Runtime options

    

  -f, [--force]    # Overwrite files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -s, [--skip]     # Skip files that already exist


## Description

    

    The model generator creates stubs for a new user model.

    The generator takes a model name as its argument.  The
    model name may be given in CamelCase or under_score and
    should not be suffixed with 'Model'.

    The generator creates a model class in app/models, invokes
    the hobo:user_mailer andgenerator the test framework.


## Examples

    

    $ rails generate hobo:user_model User
