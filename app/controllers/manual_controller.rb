class ManualController < ApplicationController
  
  caches_page :index, :manual_section, :manual_subsection

  def self.create_ordered_hash(llist)
    hash = ActiveSupport::OrderedHash.new
    llist.each do |key, value|
      hash[key] = value
    end
    hash
  end
  
  TITLES = self.create_ordered_hash([['to-do',        "To Do List"],
                                     ['dryml-guide',  "The DRYML Guide"],
                                     ['permissions',  "The Permission System"],
                                     ['controllers',  "Controllers and Routing"],
                                     ['lifecycles',   'Lifecycles'],
                                     ['viewhints',    'View Hints'],
                                     ['scopes',       'Automatic Named Scopes'],
                                     ['hobosupport',  'Hobo Support'],
                                     ['hobofields',   'Hobo Fields'],
                                     ['generators',   'Generators'],
                                    ])

  SUBTITLES = {
    'hobofields' => self.create_ordered_hash([['rich_types',         'Rich Types'],
                                              ['hobofields_api',     'API'],
                                              ['migration_generator','Migration Generator']]),
    'hobosupport' => self.create_ordered_hash([['enumerable',        'Enumerable'],
                                               ['hash',              'Hash'],
                                               ['implies',           'Implies'],
                                               ['metaid',            'Metaid'],
                                               ['methodphitamine',   'Methodphitamine'],
                                               ['module',            'Module']]),
    'generators' => self.create_ordered_hash([['hobo',                  'hobo'],
                                              ['hobo_rapid',            'hobo_rapid'],
                                              ['hobo_model',            'hobo_model'],
                                              ['hobo_model_controller', 'hobo_model_controller'],
                                              ['hobo_model_resource',   'hobo_model_resource'],
                                              ['hobo_front_controller', 'hobo_front_controller'],
                                              ['hobo_user_model',       'hobo_user_model'],
                                              ['hobo_user_controller',  'hobo_user_controller'],
                                              ['hobo_subsite',          'hobo_subsite'],
                                              ['hobo_admin_site',       'hobo_admin_site'],
                                              ['hobofield_model',       'hobofield_model'],
                                              ['hobo_migration',        'hobo_migration']])
  }

  def manual_section
    section      = params[:section].gsub(/[^a-z_\-]/, '')
    filename     = "manual/#{section}.markdown"
    @title       = TITLES[section]
    @subtitles   = SUBTITLES[section]
    @content     = HoboFields::MarkdownString.new(File.read("#{RAILS_ROOT}/#{filename}"))
    @last_update = last_update filename
  end

  def manual_subsection
    section      = params[:section].gsub(/[^a-z_\-]/, '')
    subsection   = params[:subsection].gsub(/[^a-z_\-]/, '')
    filename     = "manual/#{section}/#{subsection}.markdown"
    @title       = TITLES[section]
    @subtitles   = SUBTITLES[section]
    @current_subtitle    = SUBTITLES[section][subsection]
    @content     = HoboFields::MarkdownString.new(File.read("#{RAILS_ROOT}/#{filename}"))
    @last_update = last_update filename
  end

end
