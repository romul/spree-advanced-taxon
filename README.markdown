Advanced Taxon
---------------

This [Spree](http://github.com/railsdog/spree/tree/master) extension adds an opportunity to attach a picture and description for the taxon.

Advanced properties can be set by route `/admin/taxons/:id/advanced/edit/`

You must independently provide links to `admin_adv_edit_taxon_url(@taxon.id)` in your site extension.

For example in `taxonomy.js`:

    // ...
    conf = {
      ui : {
        theme_path  : "/javascripts/jsTree/source/themes/",
		theme_name	: "spree",
        context     : [
        {
            id      : "create",
            label   : "Create",
            icon    : "create.png",
            visible : function (NODE, TREE_OBJ) { if(NODE.length != 1) return false; return TREE_OBJ.check("creatable", NODE); },
            action  : function (NODE, TREE_OBJ) { TREE_OBJ.create({ attributes : { 'rel' : 'taxon' } }, TREE_OBJ.get_node(NODE)); }
        },
        "separator",
        // begin new code
        {
            id      : "adv_edit",
            label   : "Advanced edit",
            icon    : "adv_edit.png",
            visible : function (NODE, TREE_OBJ) { if(NODE.length != 1 || NODE[0].id == 'root') return false; return TREE_OBJ.check("renameable", NODE); },
            action  : function (NODE, TREE_OBJ) { jQuery.each(NODE, function () { window.location.replace("/admin/taxons/" + this.id + "/advanced/edit/"); }); }
        },
        // end new code
        // ... 