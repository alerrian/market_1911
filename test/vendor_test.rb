require 'Minitest/autorun'
require 'Minitest/pride'
require_relative '../lib/vendor'
require_relative '../lib/item'

class VendorTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: '$0.75'})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new('Rocky Mountain Fresh')
  end

  def test_vendor_exists
    assert_instance_of Vendor, @vendor
  end

  def test_vendor_has_attributes
    assert_equal 'Rocky Mountain Fresh', @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_stock_defaults_zero
    assert_equal 0, @vendor.check_stock(@item1)
    assert_equal 0, @vendor.check_stock(@item2)
  end

  def test_a_vendor_can_add_stock
    @vendor.add_stock(@item1, 30)

    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.add_stock(@item1, 25)

    assert_equal 55, @vendor.check_stock(@item1)

    @vendor.add_stock(@item2, 12)

    assert_equal 12, @vendor.check_stock(@item2)

    assert_equal ({@item1 => 55, @item2 => 12}), @vendor.inventory
  end
end
