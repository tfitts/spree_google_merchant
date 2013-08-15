SpreeGoogleMerchant
===============

This extension allows you to use Google Merchant to list products for free that will appear in Google Product Search (http://www.google.com/shopping).

[Learn more about Google Merchant](http://support.google.com/merchants/bin/answer.py?hl=en&answer=160540)

For product feed field definitions, (consult http://support.google.com/merchants/bin/answer.py?hl=en&answer=188494#US)

Forked from github.com/jumph4x/spree-google-base, updated for Spree 2.0, removed taxon map and need to install migrations

INSTALLATION
------------

1. Create Google Merchant account. Create Google Merchant ftp account (if applicable). Create data feed in Google Merchant with a type "Products" and name "google_merchant.xml".

2. Set preferences in spree admin panel (/admin/google_merchant_settings) for the feed title, public domain, feed description, ftp login and password. FTP login is not required - you may schedule upload from the public directory.

3. Issue the command 'rake spree_google_merchant:generate_and_transfer' to generate feed. Verify feed exists (YOUR_APP_ROOT/public/google_merchant.xml).


ADVANCED CONFIGURATION
------------

You can modify fields set for export and list of 'g:' attributes. Look at config/initializers/google_merchant.rb
You can override values of google_merchant_ATTR_MAP and google_merchant_FILTERED_ATTRS arrays with help of Array#delete, Array#delete_at, Array#<<, Array#+=, etc.
Also you can override methods from product_decorator.rb in your site extension.


CRONJOBS
--------

There are two options to regulate Google Merchant product update:

A) Setup cronjobs to run 'rake spree_google_merchant:generate' and 'rake spree_google_merchant:transfer'


Development of this extension is sponsored by [End Point][1] and by [FCP Groton][2].

[1]: http://www.endpoint.com/
[2]: http://www.fcpgroton.com/
