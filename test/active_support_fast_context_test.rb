require 'rubygems'
require 'active_support'
require 'redgreen'
require 'shoulda'
require File.join(File.dirname( __FILE__), '..', 'lib', 'fast_context.rb')

$TOP_SETUP_COUNT = 0
$INNER_SETUP_COUNT = 0
$INNER_MOST_SETUP_COUNT = 0

class ActiveSupportFastContextTest < ActiveSupport::TestCase
  
  context "And running a proper shoulda context" do
    should "not break at all" do
      assert true
    end  
  end
  
  fast_context "Top fast_context" do
    setup do 
      $TOP_SETUP_COUNT += 1
    end
    
    should "test something" do
      assert true
    end
    
    should "and test something else" do
      assert true
    end
    
    fast_context "Inner fast_context" do
      setup do
        $INNER_SETUP_COUNT += 1
      end
      
      should "test something in the inner fast_context" do
        assert true
      end
      
      should "and test something else in the inner fast_context" do
        assert true
      end
      
      fast_context "Inner-most fast_context" do
        setup do 
          $INNER_MOST_SETUP_COUNT += 1
        end
        
        should "test something in the inner-most fast_context" do
          assert true
        end
        
        should "and test something else in teh inner-most fast_context" do
          assert true
        end        
      end
    end
  end
  
  def test_setup_call_counts
    assert_equal(3, $TOP_SETUP_COUNT)
    assert_equal(2, $INNER_SETUP_COUNT)
    assert_equal(1, $INNER_MOST_SETUP_COUNT)
  end
end