Generators -- subsite\_taglib
{: .document-title}


## Usage

    

  rails generate hobo:subsite_taglib NAME [options]


## Options

    

      [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                 # Default: user
  -i, [--invite-only]                            # Add features for an invite only website


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    

    This generator is used to generate
    app/views/taglibs/<subsite_name>_site.dryml, and is used by the
    subsite and admin_site generators.  Do not use directly.
