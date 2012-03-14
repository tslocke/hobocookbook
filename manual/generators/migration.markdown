Generators -- manual/generators/migration.markdown
{: .document-title}


## Usage

    

    rails generate hobo:migration [NAME] [options]


## Options

    

    -g, [--generate]      # Don't prompt for action - generate the migration
    -n, [--default-name]  # Don't prompt for a migration name - just pick one
    -m, [--migrate]       # Don't prompt for action - generate and migrate
    -d, [--drop]          # Don't prompt with 'drop or rename' - just drop everything


## Runtime options

    

    -f, [--force]    # Overwrite files that already exist
    -q, [--quiet]    # Supress status output
    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    


          This generator compares your existing schema against the
          schema declared inside your fields declarations in your
          models.

          If the generator finds differences, it will display the
          migration it has created, and ask you if you wish to
          [g]enerate migration, generate and [m]igrate now or [c]ancel?
          Enter "g" to just generate the migration but do not run it.
          Enter "m" to generate the migration and run it, or press "c"
          to do nothing.

          The generator will then prompt you for the migration name,
          supplying a numbered default name.

          The generator is conservative and will prompt you to resolve
          any ambiguities.


## Examples

    


          $ rails generate hobo:migration

          ---------- Up Migration ----------
          create_table :foos do |t|
            t.datetime :created_at
            t.datetime :updated_at
          end
          ----------------------------------

          ---------- Down Migration --------
          drop_table :foos
          ----------------------------------
          What now: [g]enerate migration, generate and [m]igrate now or [c]ancel? m

          Migration filename:
          (you can type spaces instead of '_' -- every little helps)
          Filename [hobo_migration_2]: create_foo
                exists  db/migrate
                create  db/migrate/20091023183838_create_foo.rb
          (in /work/foo)
          ==  CreateFoo: migrating ======================================================
          -- create_table(:yos)
             -> 0.0856s
          ==  CreateFoo: migrated (0.0858s) =============================================


