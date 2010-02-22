# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AdvancedTaxonExtension < Spree::Extension
  version "0.1"
  description "Adds an opportunity to attach a picture and description for the taxon."
  url "http://yourwebsite.com/extended_taxon"

  # Please use extended_taxon/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate

    Admin::TaxonsController.class_eval do
      def edit
        load_object
        unless request.get?
          if @taxon.update_attributes(params[:taxon])
            flash[:notice] = t('advanced_taxon.succesfully_updated')
            redirect_to edit_admin_taxonomy_url(@taxon.taxonomy)
          end
        end
      end
    end


    Taxon.class_eval do
      validates_presence_of :name
      has_attached_file :icon,
                    :styles => { :mini => '32x32>', :normal => '128x128>' },
                    :default_style => :mini,
                    :url => "/assets/taxons/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/taxons/:id/:style/:basename.:extension",
                    :default_url => "/images/default_taxon.png"
    end

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end

