require "./spec_helper"

Spec2.describe DiamondKata do
  # TODO: Write tests

  it "works" do
    Quick.check("stuff", [x : Int32, y : Int32]) do
      x >= y
    end
  end
end
