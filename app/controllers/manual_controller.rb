class ManualController < ApplicationController

  caches_page :manual_section, :manual_subsection
  def self.create_ordered_hash(llist)
    hash = ActiveSupport::OrderedHash.new
    llist.each do |key, value|
      hash[key] = value
    end
    hash
  end

  TITLES = self.create_ordered_hash([# ['to-do',        "To Do List"],
    ['toc',          "Table of Contents"],
    ['download',     "Download and Install"],
    ['hobo_support', 'Hobo Support'],
    ['hobo_fields',  'Hobo Fields'],
    ['scopes',       'Automatic Named Scopes'],
    ['permissions',  "The Permission System"],
    ['multi_model_forms', 'Accessible Associations'],
    ['users_and_authentication', 'Users and Authentication'],
    ['model',       'Miscellaneous Model Extensions'],
    ['controllers',  "Controllers and Routing"],
    ['dryml-guide',  "The DRYML Guide"],
    ['ajax',         'Ajax in Hobo'],
    ['lifecycles',   'Lifecycles'],
    ['viewhints',    'View Hints'],
    ['generators',   'Generators'],
    ['i18n',         'Internationalization'],
  ])

  SUBTITLES = {
    'hobo_fields' => self.create_ordered_hash([['rich_types',         'Rich Types'],
      ['api',                'API'],
      ['migration_generator','Migration Generator'],
      #                                               ['generators',         'Generators'],
      #                                               ['interactive_primary_key', 'Interactive Primary Key'],
      ['migration_generator_comments', 'Migration Generator Comments']
    ]),
    'hobo_support' => self.create_ordered_hash([['chronic',           'Chronic'],
      ['enumerable',        'Enumerable'],
      ['hash',              'Hash'],
      ['implies',           'Implies'],
      ['metaid',            'Metaid'],
      ['methodphitamine',   'Methodphitamine'],
      ['module',            'Module'],
      ['xss',               'XSS'],
    ]),
    'generators' => self.create_ordered_hash([['admin_subsite',      'admin_subsite'],
      ['assets',             'assets'],
      ['controller',         'controller'],
      ['front_controller',   'front_controller'],
      ['i18n',               'i18n'],
      ['migration',          'migration'],
      ['model',              'model'],
      ['rapid',              'rapid'],
      ['resource',           'resource'],
      ['routes',             'routes'],
      ['setup_wizard',       'setup_wizard'],
      ['subsite',            'subsite'],
      ['subsite_taglib',     'subsite_taglib'],
      ['test_framework',     'test_framework'],
      ['user_controller',    'user_controller'],
      ['user_mailer',        'user_mailer'],
      ['user_model',         'user_model'],
      ['user_resource',      'user_resource']])

  }

  def manual_section
    section      = params[:section].gsub(/[^a-z0-9_\-]/, '')
    filename     = "manual/#{section}.markdown"
    @title       = TITLES[section]
    @subtitles   = SUBTITLES[section]
    @content     = HoboFields::Types::MarkdownString.new(File.read("#{Rails.root}/#{filename}"))
    @last_update = last_update filename
    # render 'manual_section.dryml'
  end

  def manual_subsection
    section      = params[:section].gsub(/[^a-z0-9_\-]/, '')
    subsection   = params[:subsection].gsub(/[^a-z0-9_\-]/, '')
    filename     = "manual/#{section}/#{subsection}.markdown"
    @title       = TITLES[section]
    @subtitles   = SUBTITLES[section]
    @current_subtitle    = SUBTITLES[section][subsection]
    @content     = HoboFields::Types::MarkdownString.new(File.read("#{Rails.root}/#{filename}"))
    @last_update = last_update filename
    render :manual_subsection
  end

  def index
    redirect_to :action => "manual_section", :section => "toc"
  end

end

