Generators -- manual/generators/routes.markdown
{: .document-title}


## Usage

    

    rails generate hobo:routes  [options]


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      This generator prepares the auto routes for your Application.
      It is automatically used internally, so you should not use it manually


## Example

    

      rails generate hobo:routes

      This will create:
          config/hobo_routes.rb
