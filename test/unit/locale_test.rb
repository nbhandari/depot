require 'test_helper'

class LocaleTest < ActiveSupport::TestCase
  
  test "english page title" do
    locale = 'en'
    I18n.locale = locale
    
    assert_equal "MY DEPOT", I18n.t('layout.title')
  end
  
  test "english order prompt" do
    locale = 'en'
    I18n.locale = locale
    
    assert_equal "Please select a type", I18n.t('order.prompt')
  end

  test "english order paytype po" do
    locale = 'en'
    I18n.locale = locale
    
    assert_equal "Purchase Order", I18n.t('order.paytype.po')
  end
  
  test "hindi page title" do
    locale = 'hi'
    I18n.locale = locale
    
    assert_equal "Meri Dukaan", I18n.t('layout.title')
  end
  
  test "default page title" do
    #~ default locale is English
    assert_equal "MY DEPOT", I18n.t('layout.title')
  end

end
