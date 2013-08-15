require 'spec_helper'

describe SpreeGoogleMerchant::FeedBuilder do
  
  describe 'as class' do
    context '#builders should return an array for each store' do
      Spree::Store.delete_all
      Factory :store, :domains => 'www.mystore.com', :code => 'first', :name => 'Goodies, LLC'
      Factory :store, :domains => 'www.anotherstore.com', :code => 'second', :name => 'Gifts, LLC'

      builders = SpreeGoogleMerchant::FeedBuilder.builders
      builders.size.should == 2
    end
  end

  describe 'as instance' do
    before{ @output = '' } 
    describe 'in general' do
      before(:each) do
        Spree::GoogleMerchant::Config.set(:public_domain => 'http://mydomain.com')
        Spree::GoogleMerchant::Config.set(:store_name => 'Froggies')
       
        @builder = SpreeGoogleMerchant::FeedBuilder.new
        @xml = Builder::XmlMarkup.new(:target => @output, :indent => 2, :margin => 1)
        @product = Factory(:product)
      end
      
      it 'should include products in the output' do
        @builder.build_product(@xml, @product)
        
        @output.should include(@product.name)
        @output.should include("products/#{@product.permalink}")
        @output.should include(@product.price.to_s)
      end
      
      it 'should build the XML and not bomb' do
        @builder.generate_xml @output
        
        @output.should =~ /#{@product.name}/
        @output.should =~ /Froggies/
      end
      
    end
  
    describe 'w/ store defined' do
      before(:each) do
        @store = Factory :store, :domains => 'www.mystore.com', :code => 'first', :name => 'Goodies, LLC'
        @store2 = Factory :store, :domains => 'www.anotherstore.com', :code => 'second', :name => 'Gifts, LLC'
        @builder = SpreeGoogleMerchant::FeedBuilder.new(:store => @store)
      end
      
      it "should know its path relative to the store" do
        @builder.path.should == "#{::Rails.root}/tmp/google_merchant_v#{@store.code}.xml"
      end
      
      it "should initialize with the correct domain" do
        @builder.domain.should == @store.domains.match(/[\w\.]+/).to_s 
      end
      
      it "should initialize with the correct scope" do
        @builder.ar_scope.to_sql.should == Spree::Product.by_store(@store).google_merchant_scope.scoped.to_sql
      end
      
      it "should initialize with the correct title" do
        @builder.title.should == @store.name
      end
      
      it 'should include stores meta' do
        @xml = Builder::XmlMarkup.new(:target => @output, :indent => 2, :margin => 1)
        @product = Factory(:product)
        
        @builder.build_meta(@xml)
        
        @output.should =~ /#{@store.name}/
        @output.should =~ /#{@store.domains}/
      end
      
      it 'should include only the right products' do
        @xml = Builder::XmlMarkup.new(:target => @output, :indent => 2, :margin => 1)
        needed_product = Factory(:product, :stores => [@store])
        wrong_product = Factory(:product, :stores => [@store2], :name => 'This does NOT belong in the first store')
        
        @builder.generate_xml @output
        @output.should =~ /#{needed_product.name}/
        @output.should_not =~ /#{wrong_product.name}/
      end
    end
    
    describe 'w/out stores' do
      
      before(:each) do
        Spree::GoogleMerchant::Config.set(:public_domain => 'http://mydomain.com')
        Spree::GoogleMerchant::Config.set(:store_name => 'Froggies')
        
        @builder = SpreeGoogleMerchant::FeedBuilder.new
      end
      
      it "should know its path" do
        @builder.path.should == "#{::Rails.root}/tmp/google_merchant_v.xml"
      end
      
      it "should initialize with the correct domain" do
        @builder.domain.should == Spree::GoogleMerchant::Config[:public_domain]
      end
      
      it "should initialize with the correct scope" do
        @builder.ar_scope.to_sql.should == Spree::Product.google_merchant_scope.scoped.to_sql
      end
      
      it "should initialize with the correct title" do
        @builder.title.should == Spree::GoogleMerchant::Config[:store_name]
      end
      
      it 'should include configured meta' do
        @xml = Builder::XmlMarkup.new(:target => @output, :indent => 2, :margin => 1)
        @product = Factory(:product)
        
        @builder.build_meta(@xml)
        
        @output.should =~ /Froggies/
        @output.should =~ /http:\/\/mydomain.com/
      end
    end
  end
  
  describe 'when misconfigured' do
    it 'should raise an exception' do
      SpreeGoogleMerchant::FeedBuilder.new.should raise_error
    end
  end
  
end
