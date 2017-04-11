#-------------------------------------------------------------------------------
# DCD completeion.
#-------------------------------------------------------------------------------
_dcd() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions
  for dir in $(_dcd_dirs $(_dversion $drupal_root)); do
    [ -d $dir ] && suggestions="$suggestions "$(find $drupal_root/$dir -maxdepth 1 -type d -name '[^.]*' -exec basename {} \;)
  done

  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dcd dcd

#-------------------------------------------------------------------------------
# DL completeion.
#-------------------------------------------------------------------------------
_dl() {
  COMPREPLY=()

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  # TODO: Create more complete list of modules.
  local suggestions='token ctools pathauto admin_toolbar devel metatag field_group google_analytics layout_plugin entity_reference_revisions entity video_embed_field config_update libraries paragraphs redirect ds views_slideshow inline_entity_form simple_sitemap imce captcha colorbox contact_storage features entity_browser media_entity contact_block embed field_collection entity_embed page_manager search_api backup_migrate panels crop recaptcha media_entity_image blazy xmlsitemap honeypot smtp address editor_advanced_link views_infinite_scroll dropzonejs superfish addtoany slick linkit simplenews mailsystem yamlform geolocation image_url_formatter scheduler restui taxonomy_menu block_class composer_manager menu_link_attributes better_exposed_filters workbench_moderation editor_file block_visibility_groups views_templates file_entity rules video php adminimal_admin_toolbar menu_block search_api_solr file_browser sitemap image_widget_crop eu_cookie_compliance webform calendar migrate_plus media_entity_document simple_gmap twig_tweak sharethis focal_point coffee components at_tools image_effects facets easy_breadcrumb extlink slick_views media_entity_twitter social_media_links flexslider swiftmailer migrate_tools media_entity_instagram panelizer entityqueue views_bootstrap typed_data youtube jssor weight default_content formblock masquerade color_field juicebox twitter_block csv_serialization slick_media bootstrap_layouts media_entity_slideshow profile chosen acquia_connector migrate_source_csv views_field_view mailchimp scheduled_updates email_registration smart_trim panelbutton feeds ubercart diff colorbutton externalauth advagg exclude_node_title geofield blog content_access bootstrap_library views_accordion yoast_seo state_machine filefield_paths context menu_trail_by_path fontyourface group geocoder memcache draggableviews field_formatter_class disqus mollom blocktabs field_permissions taxonomy_manager colorbox_inline workbench override_node_options token_filter dynamic_entity_reference menu_breadcrumb seckit ckeditor_media_embed languageicons ng_lightbox pathologic anchor_link fb_likebox responsive_menu custom_search imagemagick flag allowed_formats piwik ultimate_cron eck markup maxlength ckeditor_font magnific_popup poll rabbit_hole colorbox_load views_php domain country cas asset_injector gdoc_field tvi shield robotstxt key iframe slick_extras eform cors votingapi autologout login_security simplify shs twig_field_value gtranslate acsf message back_to_top examples taxonomy_access_fix image_raw_formatter plupload instagram_block google_map_field search404 codesnippet securelogin fontawesome search_api_page node_clone lang_dropdown purge masonry background_image_formatter styleguide special_menu_items leaflet toolbar_menu entity_clone masonry_views views_autocomplete_filters session_limit config_devel entity_print flippy social_login fieldblock title content_browser better_formats geophp wysiwyg_template workflow linked_field views_data_export linkicon sharemessage node_view_permissions mimemail link_attributes better_normalizers plugin security_review config_readonly audiofield classy_paragraphs migrate_upgrade media module_filter media_entity_audio bg_image_formatter menu_attributes layouter adsense config_rewrite insert_view radix_layouts commerce roleassign view_unpublished videojs easy_social user_registrationpassword soundcloudfield search_autocomplete form_placeholder fences views_load_more rdfui services computed_field unlimited_number office_hours empty_page role_delegation search_api_autocomplete tablefield current_page_crumb simple_fb_connect rename_admin_paths faqfield cookieconsent cdn m4032404 search_kint views_photo_grid environment_indicator import config_inspector spamspan ldap markdown hreflang select_or_other inline_responsive_images css_editor acl simple_oauth simplesamlphp_auth double_field galleryformatter entity_reference_views_select dropdown_language ultimenu super_login similarterms redis password_policy name toolbar_anti_flicker memcache_storage advanced_text_formatter menu_admin_per_menu stage_file_proxy simplenews_scheduler nice_menus contact_storage_export amp purge_purger_http filefield_sources empty_front_page courier login_destination entityblock key_value addanother media_expire blockgroup flysystem link_class cshs photos multiversion prepopulate statistics_counter publishcontent media_entity_browser mathjax flood_unblock styles_api workbench_access replication viewsreference scroll_to_top yaml_editor s3fs r4032login jdrupal flickity shortcode machine_name_widget fast_404 video_filter login_history views_advanced_routing geshifilter fitvids user_default_page plupload_widget hms_field checklistapi tagclouds flysystem_s3 facebook_comments_block conditional_styles auto_entitylabel rng range reroute_email field_tokens entityform_block workbench_email pdf ckeditor_bootstrap_buttons image_style_quality conflict backup_db search_api_attachments media_entity_video link_css workspace colossal_menu ckeditor_entity_link varnish_purge prlp migrate_manifest simple_adsense varnish ckeditor_youtube drupalmoduleupgrader fpa encrypt text_resize field_validation bootstrap_site_alert block_styles search_api_sorts views_autocomplete_api search_api_solr_multilingual views_field_formatter single_page_site permissions_by_term toolbar_themes google_analytics_reports persistent_login git_deploy twig_xdebug userprotect pagerer imagefield_slideshow db_maintenance contact_ajax block_field authorization field_group_background_image clientside_validation config_split quicktabs field_slideshow pdf_api easychart shortcutperrole login_popup xmlrpc protected_pages veoa simple_social_icons advanced_help views_tree video_embed_facebook tmgmt wunderground_weather views_block_filter_block disable_messages slick_paragraphs simple_menu_icons message_notify machine_name seo_checklist like_and_dislike footnotes twig_extender l10n_client footermap styled_google_map require_login ckeditor_codemirror ajax_comments subpathauto faq media_entity_embeddable_video shariff nodeorder ckeditor_videodetector term_reference_tree social_media responsive_menus photoswipe oauth ckeditor_smiley cacheflush printable clamav currency acquia_purge migrate_source_json migrate_api username_enumeration_prevention rest_api_doc responsive_tables_filter supercache slick_video jsonapi field_formatter jw_player hook_post_action votingapi_widgets cas_attributes views_timelinejs views_custom_cache_tag'
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dl dl

#-------------------------------------------------------------------------------
# DCONF completeion.
#-------------------------------------------------------------------------------
_dconf() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions=$(find $drupal_root/sites/default -maxdepth 1 -type f -exec basename {} \;)

  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dconf dconf

#-------------------------------------------------------------------------------
# DBIN completeion.
#-------------------------------------------------------------------------------
_dbin() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions=$(find $(_dvendor $drupal_root)/bin -maxdepth 1 -executable -exec basename {} \;)
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dbin dbin
