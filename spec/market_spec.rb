require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/item'
require './lib/market'
require './lib/vendor'


RSpec.configure do |config|
  config.default_formatter = 'doc'
end

RSpec.describe 'Pantry Spec Harness' do
  before :each do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
  end

  describe 'Iteration 1' do
    it '1.1 Item Instantiation' do
      expect(Item).to respond_to(:new).with(1).argument
      expect(@item1).to be_an_instance_of(Item)
    end

    it '1.2 Item #name' do
      expect(@item1).to respond_to(:name).with(0).argument
      expect(@item1.name).to eq('Peach')
    end

    it '1.3 Item #price' do
      expect(@item1).to respond_to(:price).with(0).argument
      expect(@item1.price).to eq('$0.75')
    end

    it '1.4 Vendor Instantiation' do
      expect(Vendor).to respond_to(:new).with(1).argument
      expect(@vendor1).to be_an_instance_of(Vendor)
    end

    it '1.5 Vendor #name' do
      expect(@vendor1).to respond_to(:name).with(0).argument
      expect(@vendor1.name).to eq('Rocky Mountain Fresh')
    end

    it '1.6 Vendor #inventory' do
      expect(@vendor1).to respond_to(:inventory).with(0).argument
      expect(@vendor1.inventory).to eq({})
    end

    it '1.7 Vendor #check_stock' do
      expect(@vendor1).to respond_to(:check_stock).with(1).argument
      expect(@vendor1.check_stock(@item1)).to eq(0)
    end

    it '1.8 Vendor #stock' do
      expect(@vendor1).to respond_to(:stock).with(2).argument
      @vendor1.stock(@item1, 30)
      @vendor1.stock(@item1, 25)
      @vendor1.stock(@item2, 12)

      expect(@vendor1.check_stock(@item1)).to eq(55)
      expect(@vendor1.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end

  describe 'Iteration 2' do
    before :each do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market = Market.new("South Pearl Street Farmers Market")
    end

    it '2.1 Market Instantiation' do
      expect(Market).to respond_to(:new).with(1).argument
      expect(@market).to be_an_instance_of(Market)
    end

    it '2.2 Market #name' do
      expect(@market).to respond_to(:name).with(0).argument
      expect(@market.name).to eq("South Pearl Street Farmers Market")
    end

    it '2.3 Market #vendors' do
      expect(@market).to respond_to(:vendors).with(0).argument
      expect(@market.vendors).to eq([])
    end

    it '2.4 Market #add_vendor' do
      expect(@market).to respond_to(:add_vendor).with(1).argument
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it '2.5 Market #vendor_names' do
      expect(@market).to respond_to(:vendor_names).with(0).argument
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '2.6 Market #vendors_that_sell' do
      expect(@market).to respond_to(:vendors_that_sell).with(1).argument
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe 'Iteration 3' do
    before :each do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market = Market.new("South Pearl Street Farmers Market")
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
    end

    it '3.1 Market #sorted_item_list' do
      expect(@market).to respond_to(:sorted_item_list).with(0).argument
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end

    it '3.1 Market #total_inventory' do
      expect(@market).to respond_to(:total_inventory).with(0).argument
      expect(@market.total_inventory).to eq({@item1 => 100, @item2 => 7, @item4 => 50, @item3 => 25})
    end
  end

  describe 'Iteration 4' do
    it '4.1 Market #sell' do
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: '$0.50'})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      item5 = Item.new({name: 'Onion', price: '$0.25'})
      market = Market.new("South Pearl Street Farmers Market")
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor3 = Vendor.new("Palisade Peach Shack")
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock("Peach-Raspberry Nice Cream", 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market).to respond_to(:sell).with(2).argument

      expect(market.sell(item1, 200)).to eq(false)
      expect(market.sell(item5, 1)).to eq(false)
      expect(market.sell(item4, 5)).to eq(true)
      expect(vendor2.check_stock(item4)).to eq(45)
      expect(market.sell(item1, 40)).to eq(true)
      expect(vendor1.check_stock(item1)).to eq(0)
      expect(vendor3.check_stock(item1)).to eq(60)
    end
  end
end
