<?php

/**
 * Return an array of the modules to be enabled when this profile is installed.
 *
 * @return
 *   An array of modules to enable.
 */
function eesc_ext_profile_modules() {
  // Core modules to add
  $ret= array('aggregator', 'book', 'color', 'help', 'menu', 'path', 'php', 'taxonomy', 'translation', 'trigger', 'upload', 'dblog');

  // Non-core modules
  $ret[]='admin_menu';
  $ret[]='advanced_help';
  $ret[]='auto_nodetitle';
  $ret[]='blocks404';
  $ret[]='content';
  $ret[]='content_copy';
  $ret[]='ctools';
  $ret[]='date_api';
  $ret[]='date';
  $ret[]='date_timezone';
  $ret[]='date_tools';
  $ret[]='date_popup';
  $ret[]='date_repeat';
  $ret[]='diff';
  $ret[]='emfield';
  $ret[]='emaudio';
  $ret[]='email';
  $ret[]='emimage';
  $ret[]='emvideo';
  $ret[]='features';
  $ret[]='fieldgroup';
  $ret[]='filefield';
  $ret[]='filefield_sources';
  $ret[]='globalredirect';
  $ret[]='image_resize_filter';
  $ret[]='imageapi';
  $ret[]='imageapi_gd';
  $ret[]='imagecache';
  $ret[]='imagecache_ui';
  $ret[]='imagefield';
  $ret[]='imce';
  $ret[]='imce_wysiwyg';
  $ret[]='jcarousel';
  $ret[]='jquery_ui';
  $ret[]='link';
  $ret[]='lightbox2';
  $ret[]='menu_breadcrumb';
  $ret[]='nodereference';
  $ret[]='nodereference_url';
  $ret[]='number';
  $ret[]='optionwidgets';
  $ret[]='openlayers';
  $ret[]='openlayers_geocoder';
  $ret[]='osu_search';
  $ret[]='path_redirect';
  $ret[]='pathauto';
  $ret[]='pathfilter';
  $ret[]='profile';
  $ret[]='site_map';
  $ret[]='skinr';
  $ret[]='text';
  $ret[]='token';
  $ret[]='transliteration';
  $ret[]='userreference';
  $ret[]='vertical_tabs';
  $ret[]='views';
  $ret[]='views_attach';
  $ret[]='views_export';
  $ret[]='views_slideshow';
  $ret[]='photo_gallery';
  $ret[]='viewscarousel';
  $ret[]='views_ui';
  $ret[]='wysiwyg';
  $ret[]='xmlsitemap';
	/**
	* Due to a setup bug in the system table Filefield and Imagefield have to be
	* turned on in profile_task_list.
	*/

  return $ret;
}


/**
 * Return a description of the profile for the initial installation screen.
 *
 * @return
 *   An array with keys 'name' and 'description' describing this profile,
 *   and optional 'language' to override the language selection for
 *   language-specific profiles.
 */
function eesc_ext_profile_details() {
  return array(
    'name' => 'EESC Ext',
    'description' => 'Select this profile to enable OSU and EESC supported contributed modules and the EESC/ext theme.',
    'language' => 'en'
  );
}

/**
 * Return a list of tasks that this profile supports.
 *
 * @return
 *   A keyed array of tasks the profile will perform during
 *   the final stage. The keys of the array will be used internally,
 *   while the values will be displayed to the user in the installer
 *   task list.
 */

function eesc_ext_profile_task_list() {
    return array('eesc_drupal'=>'Customizing for EESC\'s Drupal Installation');
}

/**
 * Perform any final installation tasks for this profile.
 *
 * The installer goes through the profile-select -> locale-select
 * -> requirements -> database -> profile-install-batch
 * -> locale-initial-batch -> configure -> locale-remaining-batch
 * -> finished -> done tasks, in this order, if you don't implement
 * this function in your profile.
 *
 * If this function is implemented, you can have any number of
 * custom tasks to perform after 'configure', implementing a state
 * machine here to walk the user through those tasks. First time,
 * this function gets called with $task set to 'profile', and you
 * can advance to further tasks by setting $task to your tasks'
 * identifiers, used as array keys in the hook_profile_task_list()
 * above. You must avoid the reserved tasks listed in
 * install_reserved_tasks(). If you implement your custom tasks,
 * this function will get called in every HTTP request (for form
 * processing, printing your information screens and so on) until
 * you advance to the 'profile-finished' task, with which you
 * hand control back to the installer. Each custom page you
 * return needs to provide a way to continue, such as a form
 * submission or a link. You should also set custom page titles.
 *
 * You should define the list of custom tasks you implement by
 * returning an array of them in hook_profile_task_list(), as these
 * show up in the list of tasks on the installer user interface.
 *
 * Remember that the user will be able to reload the pages multiple
 * times, so you might want to use variable_set() and variable_get()
 * to remember your data and control further processing, if $task
 * is insufficient. Should a profile want to display a form here,
 * it can; the form should set '#redirect' to FALSE, and rely on
 * an action in the submit handler, such as variable_set(), to
 * detect submission and proceed to further tasks. See the configuration
 * form handling code in install_tasks() for an example.
 *
 * Important: Any temporary variables should be removed using
 * variable_del() before advancing to the 'profile-finished' phase.
 *
 * @param $task
 *   The current $task of the install system. When hook_profile_tasks()
 *   is first called, this is 'profile'.
 * @param $url
 *   Complete URL to be used for a link or form action on a custom page,
 *   if providing any, to allow the user to proceed with the installation.
 *
 * @return
 *   An optional HTML string to display to the user. Only used if you
 *   modify the $task, otherwise discarded.
 */
function eesc_ext_profile_tasks(&$task = 'profile', $url = null) {
  switch ($task) {
  case 'profile':
      // Insert default user-defined node types into the database. For a complete
      // list of available node type attributes, refer to the node type API
      // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
      $types = array(
        array(
          'type' => 'page',
          'name' => st('Page'),
          'module' => 'node',
          'description' => st("A <em>page</em>, similar in form to a <em>story</em>, is a simple method for creating and displaying information that rarely changes, such as an \"About us\" section of a website. By default, a <em>page</em> entry does not allow visitor comments and is not featured on the site's initial home page."),
          'custom' => TRUE,
          'modified' => TRUE,
          'locked' => FALSE,
          'help' => '',
          'min_word_count' => '',
        ),
        array(
          'type' => 'story',
          'name' => st('Story'),
          'module' => 'node',
          'description' => st("A <em>story</em>, similar in form to a <em>page</em>, is ideal for creating and displaying content that informs or engages website visitors. Press releases, site announcements, and informal blog-like entries may all be created with a <em>story</em> entry. By default, a <em>story</em> entry is automatically featured on the site's initial home page, and provides the ability to post comments."),
          'custom' => TRUE,
          'modified' => TRUE,
          'locked' => FALSE,
          'help' => '',
          'min_word_count' => '',
        ),
      );

      foreach ($types as $type) {
        $type = (object) _node_type_set_defaults($type);
        node_type_save($type);
      }

      // Default page to not be promoted and have comments disabled.
      variable_set('node_options_page', array('status'));
      variable_set('comment_page', COMMENT_NODE_DISABLED);

      // Don't display date and author information for all nodes by default.
      $theme_settings = variable_get('theme_settings', array());
      $theme_settings['toggle_node_info_page'] = FALSE;
			$theme_settings['toggle_node_info_announcement'] = FALSE;
			$theme_settings['toggle_node_info_album'] = FALSE;
			$theme_settings['toggle_node_info_biblio'] = FALSE;
			$theme_settings['toggle_node_info_book'] = FALSE;
			$theme_settings['toggle_node_info_gallery'] = FALSE;
			$theme_settings['toggle_node_info_poll'] = FALSE;
			$theme_settings['toggle_node_info_story'] = FALSE;
      variable_set('theme_settings', $theme_settings);

        // Set default timezone for Date module
      variable_set('date_default_timezone_name', "America/Los_Angeles");
        drupal_set_message(t('Time zone set.'));

      //set date format
      variable_set('date_format_short', 'm/d/Y - g:ia');
      variable_set('date_format_medium', 'D, m/d/Y - g:ia');
      variable_set('date_format_long', 'l, F j, Y - g:ia');
        drupal_set_message(t('Date format set'));

          //vars for file
      variable_set('file_directory_path', 'sites/default/files');
      variable_set('file_directory_temp', '/tmp');

          // create first node
      $next_nid=db_last_insert_id(node, nid);
      $next_vid=db_last_insert_id(node_revisions, vid);
      db_query("INSERT INTO {node} VALUES ($next_nid,$next_vid,'page','en', 'Home', 1, 1, 1226687855, 1226687888, 0, 1, 0, 0, 0, 0)");
      db_query("INSERT INTO {node_revisions} VALUES ($next_nid, $next_vid, '1', 'Home', '<p>To learn more about Drupal visit <a href=\"http://oregonstate.edu/cws/webtrain\">Web Train</a>. To learn more about customizing the new orange and grey themes visit <a href=\"http://oregonstate.edu/cws/drupal/theme_settings\">Theme Settings</a>. <a href=\"./login\">log in</a> to modify your site.</p>\r\n','<p>To learn more about Drupal visit <a href=\"http://oregonstate.edu/cws/webtrain\">Web Train</a>. To learn more about customizing the new orange and grey themes visit <a href=\"http://oregonstate.edu/cws/drupal/theme_settings\">Theme Settings</a>.</p>  <p><a href=\"./login\">Log in</a> to modify your site.</p>\r\n', ' ','1226687888','2')");

        //alias to point to first node
      db_query("INSERT INTO {url_alias} (`src`,`dst`) VALUES('node/$next_nid','home')");

      //variable_set('site_name','OSU Extension Service');
      variable_set('site_mail','cws-noreply@oregonstate.edu');
      variable_set('site_frontpage','home');

      //prevent public user registration
      variable_set('user_register', '0');

        //turn on caching
      variable_set('cache', '1');
        drupal_set_message(t('Cache set.'));

        //don't set a teaser length
      variable_set('teaser_length', 0);

      //update the default file types that are allowed to be uploaded
      variable_set('upload_extensions_default', 'doc xls ppt docx xlsx pptx pdf swf txt jpg jpeg gif png pps odt ods odp rtf zip csv');
      
     
			// set defaults for admin_menu
			variable_set('admin_menu_position_fixed', '1');
			variable_set('admin_menu_tweak_modules', '1');
			
			// set defaults for lightbox2
			variable_set('lightbox2_loop_slides', '1');
			variable_set('lightbox2_node_link_text', "");
			variable_set('lightbox2_download_link_text', "");
			

      //setup roles & permissions
      db_query("INSERT INTO {role} (`rid`, `name`) VALUES (3, 'author'), (4, 'advance author'), (5, 'administrator')");
      db_query("INSERT INTO {users_roles} (`uid`, `rid`) VALUES (1, 5)");
      db_query("DELETE FROM {permission} WHERE rid=1 OR rid=2");
      
      //setup permissions for the input filter module
      db_query("UPDATE {filter_formats} SET `roles` = ',5,4,' WHERE `format`= 3");
      db_query("UPDATE {filter_formats} SET `roles` = ',5,3,4,' WHERE `format`= 2");
     	db_query("INSERT INTO {permission} (`rid`, `perm`, `tid`) VALUES
	            (1, 'access news feeds, access printer-friendly version, translate interface, access content, access site map, translate content, cancel own vote, vote on polls, view imagecache thumbnail_100, view imagecache preview_500', 0),
	            (2, 'access news feeds, access printer-friendly version, view imagefield uploads, translate interface, access content, access site map, translate content, cancel own vote, vote on polls, view imagecache thumbnail_100, view imagecache preview_500', 0),
	            (3, 'view date repeats, view advanced help index, view advanced help popup, view advanced help topic, access news feeds, administer news feeds, create announcement, edit announcement, administer blocks, access printer-friendly version, add content to books, administer book outlines, create new books, create album, edit album, edit own album, access imce, view imagefield uploads, translate interface, administer menu, access content, administer nodes, create book content, create page content, create story content, delete any book content, delete any page content, delete any story content, delete own book content, delete own page content, delete own story content, delete revisions, edit any book content, edit any page content, edit any story content, edit own book content, edit own page content, edit own story content, revert revisions, view revisions, administer url aliases, create url aliases, administer pathauto, cancel own vote, create poll content, delete any poll content, delete own poll content, edit any poll content, edit own poll content, vote on polls, access site map, access administration pages, administer taxonomy, access tinymce, translate content, upload files, view uploaded files, access user profiles, view imagecache thumbnail_100, view imagecache preview_500, access user profiles, show download links, show export links, show filter tab, show own download links, show sort links, view full text, edit own biblio entries, create biblio', 0),
	            (4, 'view date repeats, view advanced help index, view advanced help popup, view advanced help topic, access news feeds, administer news feeds, create announcement, edit announcement, administer blocks, use PHP for block visibility, access printer-friendly version, add content to books, administer book outlines, create new books, Use PHP input for field settings (dangerous - grant with care), administer filters, create album, edit album, edit own album, access imce, view imagefield uploads, translate interface, administer menu, access content, administer content types, administer nodes, create book content, create page content, create story content, delete any book content, delete any page content, delete any story content, delete own book content, delete own page content, delete own story content, delete revisions, edit any book content, edit any page content, edit any story content, edit own book content, edit own page content, edit own story content, revert revisions, view revisions, administer url aliases, create url aliases, administer pathauto, cancel own vote, create poll content, delete any poll content, delete own poll content, edit any poll content, edit own poll content, vote on polls, access site map, access administration pages, administer taxonomy, access tinymce, translate content, upload files, view uploaded files, access user profiles, administer views, use views exporter, access all views, view imagecache thumbnail_100, view imagecache preview_500, access user profiles, administer views, use views exporter, access all views, show download links, show export links, show filter tab, show own download links, show sort links, view full text, edit own biblio entries, create biblio, edit all biblio entries, edit biblio authors',0),
	            (5, 'view date repeats, view advanced help index, view advanced help popup, view advanced help topic, access news feeds, administer news feeds, create announcement, edit announcement, administer blocks, use PHP for block visibility, access printer-friendly version, add content to books, administer book outlines, create new books, Use PHP input for field settings (dangerous - grant with care), administer filters, configure gallerix, create album, edit album, edit own album, access imce, administer imce, administer imageapi, view imagefield uploads, administer languages, translate interface, administer menu, access content, administer content types, administer nodes, create book content, create page content, create story content, delete any book content, delete any page content, delete any story content, delete own book content, delete own page content, delete own story content, delete revisions, edit any book content, edit any page content, edit any story content, edit own book content, edit own page content, edit own story content, revert revisions, view revisions, administer osu_sso, administer url aliases, create url aliases, administer redirects, administer pathauto, cancel own vote, create poll content, delete any poll content, delete own poll content, edit any poll content, edit own poll content, inspect all votes, vote on polls, access site map, access administration pages, administer site configuration, select different theme, administer taxonomy, access tinymce, administer tinymce, translate content, upload files, view uploaded files, access user profiles, administer permissions, administer users, administer views, use views exporter, access all views, view imagecache thumbnail_100, view imagecache preview_500, access administration menu, administer imagecache, flush imagecache, show download links, show export links, show filter tab, show own download links, show sort links, view full text, edit own biblio entries, create biblio, edit all biblio entries, edit biblio authors, administer biblio, import from file',0); ");
        drupal_set_message(t('Roles and permissions set up.'));

				//set default theme to eesc_ext
        db_query("UPDATE {system} SET status=1 WHERE name='extension'");
        variable_set('theme_default','eesc_ext');
        drupal_set_message(t('EESC Extension is now the default theme.'));

        //Set up eesc_ext's 
        variable_set('theme_eesc_ext_settings', array(
           "mission" => '',
           "default_logo" => 0,
            "logo_path" => '',
						"logo" => 0,
           "default_favicon" => 1,
           "favicon_path" => '',
           "primary_links" => 0,
           "secondary_links" => 0,
           "toggle_logo" => 0,
           "toggle_favicon" => 1,
           "toggle_name" => 1,
           "toggle_search" => 0,
           "toggle_slogan" => 0,
           "toggle_mission" => 0,
           "toggle_node_user_picture" => 0,
           "toggle_comment_user_picture" => 0,
           "toggle_primary_links" => 0,
           "toggle_secondary_links" => 0,
           "logo_upload" => '',
           "favicon_upload" => '',
           "zen_block_editing" => 1,
           "zen_breadcrumb" => 'yes',
           "zen_breadcrumb_separator" => ' > ',
           "zen_breadcrumb_home" => 1,
           "zen_breadcrumb_trailing" => 1,
           "zen_breadcrumb_title" => 0,
           "zen_rebuild_registry" => 0,
           "zen_wireframes" => 0
        ));

       // Setup WYSIWYG
            require_once(drupal_get_path('module', 'wysiwyg').'/wysiwyg.admin.inc');
            require_once(drupal_get_path('module', 'wysiwyg').'/editors/tinymce.inc');
            
            db_query("INSERT INTO {wysiwyg} (`format`, `editor`) VALUES
            (1, 'tinymce'),(2, 'tinymce'),(3, '');");

            $config = array (
                'default' => '1',
                'theme' => 'advanced',
                'buttons' => array(
                  'advimage' => array('advimage'=>'1'),
                  'advlink' => array('advlink' => '1'),
                  'default' => array('bold' => '1',
                                    'italic' => '1',
                                    'strikethrough' => '1',
                                    'justifyleft' => '1',
                                    'justifycenter' => '1',
                                    'justifyright' => '1',
                                    'justifyfull' => '1',
                                    'bullist' => '1',
                                    'numlist' => '1',
                                    'outdent' => '1',
                                    'indent' => '1',
                                    'undo' => '1',
                                    'redo' => '1',
                                    'link' => '1',
                                    'unlink' => '1',
                                    'anchor' => '1',
                                    'image' => '1',
                                    'cleanup' => '1',
                                    'sup' => '1',
                                    'sub' => '1',
                                    'code' => '1',
                                    'hr' => '1',
                                    'cut' => '1',
                                    'copy' => '1',
                                    'paste' => '1',
                                    'visualaid' => '1',
                                    'removeformat' => '1',
                                    'charmap' => '1'),
                  'font'=>array('formatselect'=>'1','styleselect'=>'1'),
                  'cmslink' => array('cmslink' => '1'),
                  'imce' => array('imce' => '1'),
                  'media' => array('media' => '1'),
                  'paste' => array('pasteword' => '1'),
                  'searchreplace' => array('search' => '1'),
                  'spellchecker' => array('spellchecker' => '1'),
                  'style' => array('styleprops' => '1'),
                  'table' => array('tablecontrols' => '1')),
                'apply_source_formatting' => 'true',
                'convert_fonts_to_spans' => 'true',
                'language' => 'en',
                'preformatted' => 'false',
                'remove_linebreaks' => 'true',
                'verify_html' => 'true',
                'css_classes' => '4-H=four_h_hue;Agriculture=agriculture_hue;FCD=fcd_hue;Forestry=forestry_hue;Sea Grant=seagrant_hue;Photo Caption=caption;Quotation=quotation;Serif Font=serif;Smaller=smallerFont;Larger=largerFont',
                'css_setting' => 'self',
								'css_path' => 'http://extension.oregonstate.edu/css/drupal/d6-editor-defaults.css',
                'path_loc' => 'bottom',
                'resizing' => 'true',
                'toolbar_loc' => 'top',
                'toolbar_align' => 'left',
                'block_formats' => 'p, h2, h3, h4, h5, h6, div, address, pre',
								'paste_auto_cleanup_on_paste' => 'true',
								'user_choose' => 'false');
								

      // Insert new tinymce profile data.
      db_query("UPDATE {wysiwyg} SET settings = '%s'", serialize($config));

      //Disable editor by default for PHP input.
      $config['default'] = 0;
      db_query("UPDATE {wysiwyg} SET settings = '%s' WHERE `format` = '3'", serialize($config)); 
    
      //turn on our form disabling features for all users but ext_dpla (disabled)
      //variable_set('osu_update_lockdown','1');
    
    //IMCE configuration
    $default_profiles = variable_get('imce_profiles',array());
    
    $default_profiles[3] = array(
         'name' => 'OSU-default',
         'filesize' => '0',
         'quota' => '0',
         'tuquota' => '0',
         'extensions' => '*',
         'dimensions' => '0',
         'filenum' => '0',
         'directories' => array(
               array(
                     'name' => '.',
                     'subnav' => '1',
                     'browse' => '1',
                     'upload' => '1',
                     'thumb' => '1',
                     'delete' => '1',
                     'resize' => '1'
                 )

             ),
         'thumbnails' => array(
                 array(
                         'name' => 'Small',
                         'dimensions' => '90x90',
                         'prefix' => 'small_',
                         'suffix' => ''
                     ),
                 array(
                         'name' => 'Medium',
                         'dimensions' => '120x120',
                         'prefix' => 'medium_',
                         'suffix' => ''
                     ),
                 array(
                         'name' => 'Large',
                         'dimensions' => '180x180',
                         'prefix' => 'large_',
                         'suffix' => ''
                     )

             )

     );
      
      //set default weight and user id 
      for($i=1;$i<6;$i++) {
          $role_profiles[$i] = array('weight' => '0', 'pid' => ($i == 1) ? '0' : '3');
      }
      
      variable_set('imce_profiles',$default_profiles);
      variable_set("imce_roles_profiles", $role_profiles);

      // Add rtsp, mms, itunes, and clsid (for flash)
 			variable_set('filter_allowed_protocols', array('http', 'https', 'ftp', 'news', 'nntp', 'telnet', 'mailto', 'irc', 'ssh', 'sftp', 'webcal', 'rtsp', 'mms', 'itms', 'clsid'));
      variable_set('node_options_announcement', array('promote','revision'));
      variable_set('node_options_story', array('revision'));
			variable_set('node_options_page', array('revision'));
			variable_set('node_options_book', array('publish', 'revision'));
			variable_set('node_options_gallery', array('publish','revision'));
			
      //setup op
      variable_set('op_announcement', 'Save content type');
      variable_set('op_page', 'Save content type');

      //setup page
      variable_set('page_template_body', '');
      variable_set('page_template_title', '');

    	//setup path auto
      variable_set('pathauto_ignore_words', 'a,an,as,at,before,but,by,for,from,is,in,into,like,of,off,on,onto,per,since,than,the,this,that,to,up,via,with');
      variable_set('pathauto_indexaliases', '');
      variable_set('pathauto_indexaliases_bulkupdate', 'b:0;');
      variable_set('pathauto_max_component_length', '100');
      variable_set('pathauto_max_length', '100');
      variable_set('pathauto_modulelist',array('node','taxonomy','user'));
      variable_set('pathauto_node_applytofeeds', '');
      variable_set('pathauto_node_bulkupdate', '');
      variable_set('pathauto_node_page_pattern', '');
      variable_set('pathauto_node_pattern', '[title-raw]');
      variable_set('pathauto_node_story_pattern', '');
      variable_set('pathauto_node_staff_pattern', 'staff/[title-raw]');
 			variable_set('pathauto_node_announcement_pattern', 'announcement/[title-raw]');
      variable_set('pathauto_node_supportsfeeds', 'feed');
      variable_set('pathauto_quotes', '0');
      variable_set('pathauto_separator', '-');
      variable_set('pathauto_taxonomy_applytofeeds', '');
      variable_set('pathauto_taxonomy_bulkupdate', '');
      variable_set('pathauto_taxonomy_pattern', '[vocab-raw]/[catpath-raw]');
      variable_set('pathauto_taxonomy_supportsfeeds', '0/feed');
      variable_set('pathauto_update_action', '0');
      variable_set('pathauto_user_bulkupdate', '');
      variable_set('pathauto_user_pattern','');
      variable_set('pathauto_user_supportsfeeds', 'N;');
      variable_set('pathauto_verbose', '');
      variable_set('pathauto_node_photo_pattern', 'photo/[title-raw]');
			variable_set('pathauto_node_gallery_pattern', 'gallery/[title-raw]');

			 //sitemap
        global $language;
        // this is strictly for sites upgrading from Drupal 5 to Drupal 6,
        // when the locale module is included
        // could be remove for Drupal 7
        if (($site_map_message = variable_get('site_map_message', NULL)) !== NULL) {
            variable_set('site_map_message_'.$language->language, $site_map_message);
            variable_del('site_map_message');
        }
        if (($site_map_show_menus = variable_get('site_map_show_menus', NULL)) !== NULL) {
            // because the table for menus changed, can't save the menu selections here. :(
            variable_del('site_map_show_menus');
        }
        // end D5 -> D6 var name changes

        $site_map_variable_defaults = array(
            'site_map_message_'.$language->language => '',
            'site_map_show_front' => '1',
            'site_map_show_blogs' => '1',
            'site_map_show_books' => array(),
            'site_map_show_menus_'.$language->language => array('primary-links'),
            'site_map_show_vocabularies' => array(),
            'site_map_books_expanded' => '1',
            'site_map_show_count' => '1',
            'site_map_categories_depth' => 'all',
            'site_map_show_rss_links' => '1',
            'site_map_rss_depth' => 'all',
        );
        foreach ($site_map_variable_defaults as $site_map_var_key => $site_map_var_val) {
            if (variable_get($site_map_var_key, NULL) === NULL) {
                variable_set($site_map_var_key, $site_map_var_val);
            }
        }
			
			  variable_set('date_default_timezone', '-25200');
        variable_set('configurable_timezones', '1');
        variable_set('date_first_day', '0');
      
				//blocks
        db_query("TRUNCATE TABLE {blocks}");
        db_query("INSERT INTO {blocks} (`module`, `delta`, `theme`, `status`, `weight`,
				    `region`, `custom`, `throttle`, `visibility`, `pages`, `title`, `cache`) VALUES
				    ('locale', '0', 'eesc_ext', 0, -6, '', 0, 0, 0, '', '', -1),
				('menu', 'primary-links', 'eesc_ext', 1, -10, 'left', 0, 0, 0, '', '', -1),
				('menu', 'secondary-links', 'eesc_ext', 1, -4, 'left', 0, 0, 0, '', '', -1),
				('node', '0', 'eesc_ext', 0, -3, '', 0, 0, 0, '', '', -1),
				('profile', '0', 'eesc_ext', 0, -9, '', 0, 0, 0, '', '', 5),
				('system', '0', 'eesc_ext', 1, 2, 'footer', 0, 0, 0, '', '', -1),
				('user', '0', 'eesc_ext', 0, -1, '', 0, 0, 0, '', '', -1),
				('user', '1', 'eesc_ext', 1, -10, 'left', 0, 0, 0, '', '', -1),
				('user', '2', 'eesc_ext', 0, -1, '', 0, 0, 0, '', '', 1),
				('user', '3', 'eesc_ext', 0, 0, '', 0, 0, 0, '', '', -1),
				('glossary', '0', 'eesc_ext', 0, -7, '', 0, 0, 0, '', '', 1),
				('glossary', '1', 'eesc_ext', 0, -8, '', 0, 0, 0, '', '', 1),
				('site_map', '0', 'eesc_ext', 0, -2, '', 0, 0, 0, '', '', 1),
				('views', 'archive-block', 'eesc_ext', 0, -10, '', 0, 0, 0, '', '', -1);");

        //Disable the aggregator menu items.
        db_query("UPDATE {menu_links} SET `hidden` = '1', `customized` = '1' WHERE `router_path` = 'aggregator';");
        db_query("UPDATE {menu_links} SET `hidden` = '1', `customized` = '1' WHERE `router_path` = 'aggregator/sources';");
        drupal_set_message(t('The News aggregator menu item has been disabled.'));

        //Disable the "Search" menu items.
        db_query("UPDATE {menu_links} SET `hidden` = '1', `customized` = '1' WHERE `router_path` = 'search';");
        drupal_set_message(t('The Search menu item has been disabled.'));

        //Move "Powered by Drupal" block outside of any regions.
        db_query("UPDATE {blocks} SET `region` = '', `status` = 0 WHERE `module` = 'system' AND `delta` = '0'");

        // Add filter priorities
        db_query("INSERT INTO {filters} (`fid`,`format`, `module`, `delta`, `weight`) VALUES
            ('',1, 'pathfilter', 0, -10),
        ('',2, 'pathfilter', 0, 1),
        ('',3, 'pathfilter', 0, -10);");


       //Disable the <br/> insertion filter
		    db_query("DELETE FROM {filters} WHERE format = 1 AND delta = 1");
		    //Disable the <br/> insertion filter
		    db_query("DELETE FROM {filters} WHERE format = 2 AND delta = 1");

				// insert imageCache presets
				$imagecachepreset = new stdClass ();
				$imagecachepreset->presetname = 'thumbnail_100';
				drupal_write_record('imagecache_preset', $imagecachepreset);

				// Action
				$imagecacheaction = new stdClass ();
				$imagecacheaction->presetid = $imagecachepreset->presetid;
				$imagecacheaction->module = 'imagecache';
				$imagecacheaction->action = 'imagecache_scale';
				$imagecacheaction->data = array(
        								'width' => '100',
                        'height' => ''
                    );
				drupal_write_record('imagecache_action', $imagecacheaction);

				// add imagecache preset
				$imagecachepreset = new stdClass ();
				$imagecachepreset->presetname = 'preview_500';
				drupal_write_record('imagecache_preset', $imagecachepreset);

				// Action
				$imagecacheaction = new stdClass ();
				$imagecacheaction->presetid = $imagecachepreset->presetid;
				$imagecacheaction->module = 'imagecache';
				$imagecacheaction->action = 'imagecache_scale';
				$imagecacheaction->data = array(
                        'width' => '500',
                        'height' => ''
                    );
				drupal_write_record('imagecache_action', $imagecacheaction);
				
				drupal_set_message(t('Imagecache presets installed.'));

      // Setup the allowed_html filter for the standard html input
      variable_set('allowed_html_1', "<a> <applet> <blockquote> <br> <cite> <code> <dd> <div> <dl> <dt> <em> <embed> <h1> <h2> <h3> <h4> <h5> <h6> <hr> <img> <li> <object> <ol> <p> <param> <pre> <span> <strike> <strong> <sub> <sup> <table> <tbody> <td> <tfoot> <th> <thead> <tr> <u> <ul>");

     	// add cache settings to settings.php
      $settings_file = getcwd().'/sites/default/settings.php';
      $cache_dir = getcwd().'/sites/default/cache';

      $cache_dir_created = (file_exists($cache_dir) && is_writable($cache_dir));
      if (!$cache_dir_created && is_writable(dirname($cache_dir))) {
          $cache_dir_created = mkdir($cache_dir);
      }
      if (is_writable($settings_file) && $cache_dir_created) {
          $cache_settings = ($GLOBALS['conf']['cache_inc'] === './includes/cache.inc' || !isset($GLOBALS['conf']['cache_inc']))
              ? '$conf[\'cache_inc\'] = dirname(dirname(dirname(__FILE__))).\'/sites/all/modules/cacherouter/cacherouter.inc\';'."\n"
              : '';
          $cache_settings .= (isset($GLOBALS['base_url']) && !isset($GLOBALS['conf']['osu_cache_site_url']))
              ? '$conf[\'osu_cache_site_url\'] = \''.$GLOBALS['base_url'].'\';'."\n"
              : '';
          if (!isset($GLOBALS['conf']['cacherouter'])) {
              $cache_settings .= '$conf[\'cacherouter\'] = array('."\n";
              $cache_settings .= '  \'default\' => array('."\n";
              $cache_settings .= '    \'engine\' => \'file\','."\n";
              $cache_settings .= '    \'server\' => array(),'."\n";
              $cache_settings .= '    \'shared\' => TRUE,'."\n";
              $cache_settings .= '    \'prefix\' => \'\','."\n";
              $cache_settings .= '    \'path\' => dirname(dirname(dirname(__FILE__))).\'/sites/default/cache\','."\n";
              $cache_settings .= '    \'static\' => FALSE,'."\n";
              $cache_settings .= '    \'fast_cache\' => TRUE,'."\n";
              $cache_settings .= '  ),'."\n";
              $cache_settings .= ');'."\n";
          }
          file_put_contents($settings_file, $cache_settings, FILE_APPEND);
      } else {
          drupal_set_message(st('If you wish to enable file caching, please refer to OSU-README.txt in sites/all/modules/cacherouter of your Drupal install.'));
      }
      break;
  }
}

/**
 * Implementation of hook_form_alter().
 *
 * Allows the profile to alter the site-configuration form. This is
 * called through custom invocation, so $form_state is not populated.
 */
function eesc_ext_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure') {
    // Set default for site name field.
    $form['site_information']['site_name']['#default_value'] = '';
    $form['site_information']['site_mail']['#default_value'] = 'cws-noreply@oregonstate.edu';
    $form['admin_account']['account']['name']['#default_value'] = 'ext_dpla';
    $form['admin_account']['account']['mail']['#default_value'] = 'extwebsupport@oregonstate.edu';
    $form['admin_account']['account']['pass']['pass1']['#default_value'] = 'not_null';
  }
}
