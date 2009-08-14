# Put your extension routes here.

map.namespace :admin do |admin|
   admin.adv_edit_taxon '/taxons/:id/advanced/edit', :controller => :taxons, :action => 'adv_edit'
end

