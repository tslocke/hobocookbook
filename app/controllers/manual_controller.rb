class ManualController < ApplicationController

  caches_page :manual_section, :manual_subsection
  def self.create_ordered_hash(llist)
    ActiveSupport::OrderedHash[llist]
  end

  TITLES = self.create_ordered_hash([# ['to-do',        "To Do List"],
                                     ['toc',               ["#{Rails.root}/manual/toc.markdown", "Table of Contents"]],
                                     ['download',          ["#{Rails.root}/manual/download.markdown", "Download and Install"]],
                                     ['changes',          ["#{Hobo.root}/CHANGES.txt", "Changes in 1.3"]],
                                     ['hobo_support',      ["#{HoboSupport.root}/test/hobosupport.rdoctest", 'Hobo Support']],
                                     ['hobo_fields',       ["#{HoboFields.root}/test/doc-only.rdoctest", 'Hobo Fields']],
                                     ['scopes',            ["#{Hobo.root}/doctests/hobo/scopes.rdoctest", 'Automatic Named Scopes']],
                                     ['permissions',       ["#{Rails.root}/manual/permissions.markdown", "The Permission System"]],
                                     ['multi_model_forms', ["#{Hobo.root}/doctests/hobo/multi_model_forms.rdoctest", 'Accessible Associations']],
                                     ['users_and_authentication',  ["#{Rails.root}/manual/users_and_authentication.markdown", 'Users and Authentication']],
                                     ['model',             ["#{Hobo.root}/doctests/hobo/model.rdoctest", 'Miscellaneous Model Extensions']],
                                     ['controllers',       ["#{Rails.root}/manual/controllers.markdown", "Controllers and Routing"]],
                                     ['dryml-guide',       ["#{Rails.root}/manual/dryml-guide.markdown", "The DRYML Guide"]],
                                     ['ajax',              ["#{Rails.root}/manual/ajax.markdown", 'Ajax in Hobo']],
                                     ['lifecycles',        ["#{Rails.root}/manual/lifecycles.markdown", 'Lifecycles']],
                                     ['viewhints',         ["#{Rails.root}/manual/viewhints.markdown", 'View Hints']],
                                     ['generators',        ["#{Rails.root}/manual/generators.markdown", 'Generators']],
                                     ['i18n',              ["#{Rails.root}/manual/i18n.markdown", 'Internationalization']],
  ])

  SUBTITLES = {
    'hobo_fields' => self.create_ordered_hash([['rich_types',         ["#{HoboFields.root}/test/rich_types.rdoctest", 'Rich Types']],
                                               ['api',                ["#{HoboFields.root}/test/api.rdoctest", 'API']],
                                               ['migration_generator',["#{HoboFields.root}/test/migration_generator.rdoctest", 'Migration Generator']],
      #                                               ['generators',         'Generators'],
      #                                               ['interactive_primary_key', 'Interactive Primary Key'],
                                               ['migration_generator_comments', ["#{HoboFields.root}/test/migration_generator_comments.rdoctest", 'Migration Generator Comments']]
    ]),
    'hobo_support' => self.create_ordered_hash([['chronic',           ["#{HoboSupport.root}/test/hobosupport/chronic.rdoctest", 'Chronic']],
                                                ['enumerable',        ["#{HoboSupport.root}/test/hobosupport/enumerable.rdoctest", 'Enumerable']],
                                                ['hash',              ["#{HoboSupport.root}/test/hobosupport/hash.rdoctest", 'Hash']],
                                                ['implies',           ["#{HoboSupport.root}/test/hobosupport/implies.rdoctest", 'Implies']],
                                                ['metaid',            ["#{HoboSupport.root}/test/hobosupport/metaid.rdoctest", 'Metaid']],
                                                ['methodphitamine',   ["#{HoboSupport.root}/test/hobosupport/methodphitamine.rdoctest", 'Methodphitamine']],
                                                ['module',            ["#{HoboSupport.root}/test/hobosupport/module.rdoctest", 'Module']],
                                                ['xss',               ["#{HoboSupport.root}/test/hobosupport/xss.rdoctest", 'XSS']],
    ]),
    'generators' => self.create_ordered_hash([['admin_subsite',      ["#{Rails.root}/manual/generators/admin_subsite.markdown", 'admin_subsite']],
                                              ['assets',             ["#{Rails.root}/manual/generators/assets.markdown", 'assets']],
                                              ['controller',         ["#{Rails.root}/manual/generators/controller.markdown", 'controller']],
                                              ['front_controller',   ["#{Rails.root}/manual/generators/front_controller.markdown", 'front_controller']],
                                              ['i18n',               ["#{Rails.root}/manual/generators/i18n.markdown", 'i18n']],
                                              ['migration',          ["#{Rails.root}/manual/generators/migration.markdown", 'migration']],
                                              ['model',              ["#{Rails.root}/manual/generators/model.markdown", 'model']],
                                              ['rapid',              ["#{Rails.root}/manual/generators/rapid.markdown", 'rapid']],
                                              ['resource',           ["#{Rails.root}/manual/generators/resource.markdown", 'resource']],
                                              ['routes',             ["#{Rails.root}/manual/generators/routes.markdown", 'routes']],
                                              ['setup_wizard',       ["#{Rails.root}/manual/generators/setup_wizard.markdown", 'setup_wizard']],
                                              ['subsite',            ["#{Rails.root}/manual/generators/subsite.markdown", 'subsite']],
                                              ['subsite_taglib',     ["#{Rails.root}/manual/generators/subsite_taglib.markdown", 'subsite_taglib']],
                                              ['test_framework',     ["#{Rails.root}/manual/generators/test_framework.markdown", 'test_framework']],
                                              ['user_controller',    ["#{Rails.root}/manual/generators/user_controller.markdown", 'user_controller']],
                                              ['user_mailer',        ["#{Rails.root}/manual/generators/user_mailer.markdown", 'user_mailer']],
                                              ['user_model',         ["#{Rails.root}/manual/generators/user_model.markdown", 'user_model']],
                                              ['user_resource',      ["#{Rails.root}/manual/generators/user_resource.markdown", 'user_resource']]])

  }

  def manual_section
    section      = params[:section].gsub(/[^a-z0-9_\-]/, '')
    filename     = TITLES[section][0]
    @title       = TITLES[section][1]
    @subtitles   = SUBTITLES[section].nil? ? nil : Hash[*SUBTITLES[section].map {|k,v| [k, v[1]]}.flatten]
    @content     = HoboFields::Types::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
    # render 'manual_section.dryml'
  end

  def manual_subsection
    section      = params[:section].gsub(/[^a-z0-9_\-]/, '')
    subsection   = params[:subsection].gsub(/[^a-z0-9_\-]/, '')
    filename     = SUBTITLES[section][subsection][0]
    @title       = TITLES[section][1]
    @subtitles   = Hash[*SUBTITLES[section].map {|k,v| [k, v[1]]}.flatten]
    @current_subtitle    = SUBTITLES[section][subsection][1]
    @content     = HoboFields::Types::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
    render :manual_subsection
  end

  def index
    redirect_to :action => "manual_section", :section => "toc"
  end

  def self.titles
    ActiveSupport::OrderedHash[*TITLES.map {|k,v| [k, v[1]]}.flatten]
  end

end

