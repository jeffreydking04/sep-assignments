include RSpec

require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:tree) { MinBinaryHeap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#insert(data)" do
    it "properly inserts a new node in an empty heap" do
      expected_output = "Pacific Rim: 72\n"
      new_tree = MinBinaryHeap.new
      new_tree.insert(pacific_rim)
      expect { new_tree.printf }.to output(expected_output).to_stdout
    end

    it "properly inserts a new node as left child" do
      tree.insert(empire)
      expect(root.left.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly swaps out root node if inserted second node has lower rating" do
      tree.insert(braveheart)
      expect(root.parent.title).to eq "Braveheart"
      expect(root.parent.left.title).to eq "The Matrix"
    end

    it "properly inserts a new node as a right child" do
      tree.insert(district)
      tree.insert(hope)
      expect(root.right.title).to eq "Star Wars: A New Hope"
    end

    it "properly swaps a third level insertion with a second level if rating is lower" do
      tree.insert(braveheart)
      tree.insert(jedi)
      tree.insert(inception)
      expect(root.parent.title).to eq "Inception"
      expect(root.parent.parent.title).to eq "Braveheart"
      expect(root.parent.left.title).to eq "The Matrix"
    end

    it "properly swaps first third level child with root if it has lower rating" do
      tree.insert(empire)
      tree.insert(hope)
      tree.insert(braveheart)
      expect(root.left.title).to eq "Star Wars: The Empire Strikes Back"
      expect(root.parent.title).to eq "Braveheart"
      expect(root.parent.left.title).to eq "The Matrix"
      expect(root.parent.right.title).to eq "Star Wars: A New Hope"
    end

    it "properly swaps new right child node with root if rating is lower" do
      tree.insert(hope)
      tree.insert(braveheart)
      expect(root.parent.title).to eq "Braveheart"
      expect(root.parent.left.title).to eq "Star Wars: A New Hope"
      expect(root.parent.right.title).to eq "The Matrix"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      tree.insert(empire)
      tree.insert(mad_max_2)
      expect(tree.find(root, nil)).to eq nil
    end

    it "properly finds a left node" do
      tree.insert(hope)
      expect(tree.find(root, hope.title).title).to eq "Star Wars: A New Hope"
    end

    it "properly finds a left-left node" do
      tree.insert(hope)
      tree.insert(shawshank)
      tree.insert(empire)
      expect(tree.find(root, empire.title).title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly finds a left-right node" do
      tree.insert(braveheart)
      tree.insert(jedi)
      tree.insert(hope)
      tree.insert(empire)
      expect(tree.find(braveheart, empire.title).title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly finds a right node" do
      tree.insert(district)
      tree.insert(empire)
      expect(tree.find(root, empire.title).title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly finds a right-left node" do
      tree.insert(braveheart)
      tree.insert(jedi)
      tree.insert(pacific_rim)
      tree.insert(inception)
      tree.insert(hope)
      expect(tree.find(pacific_rim, hope.title).title).to eq "Star Wars: A New Hope"
    end

    it "properly finds a right-right node" do
      tree.insert(braveheart)
      tree.insert(jedi)
      tree.insert(pacific_rim)
      tree.insert(inception)
      tree.insert(hope)
      tree.insert(empire)
      expect(tree.find(pacific_rim, empire.title).title).to eq "Star Wars: The Empire Strikes Back"
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(tree.delete(nil)).to eq nil
    end

    it "properly deletes a left child" do
      tree.insert(hope)
      tree.delete(hope.title)
      expect(tree.find(root, hope.title)).to be_nil
    end

    it "properly deletes a second node in a three node heap" do
      tree.insert(hope)
      tree.insert(empire)
      tree.delete(hope.title)
      expect(tree.find(root, hope.title)).to be_nil
      expect(root.left.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly deletes root in a 4 element heap" do
      tree.insert(braveheart)
      tree.insert(hope)
      tree.insert(empire)
      tree.delete(braveheart.title)
      expect(tree.find(root, braveheart.title)).to be_nil
      expect(root.parent).to be_nil
      expect(root.left.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly deletes element 2 in a 6 element heap" do
      tree.insert(braveheart)
      tree.insert(inception)
      tree.insert(jedi)
      tree.insert(empire)
      tree.insert(hope)
      tree.delete(jedi.title)
      expect(tree.find(root, jedi.title)).to be_nil
      expect(root.parent.title).to eq "Braveheart"
      expect(root.parent.parent).to be_nil
      expect(root.left.title).to eq "Star Wars: A New Hope"
      expect(root.right.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly deletes element 3 in a 4 element heap" do
      tree.insert(hope)
      tree.insert(martian)
      tree.insert(empire)
      tree.delete(martian.title)
      expect(tree.find(root, martian.title)).to be_nil
      expect(root.right.title).to eq "Star Wars: The Empire Strikes Back" 
    end

    it "properly deletes element 3 in a 6 element heap" do
      tree.insert(martian)
      tree.insert(shawshank)
      tree.insert(district)
      tree.insert(empire)
      tree.insert(hope)
      tree.delete(shawshank.title)
      expect(tree.find(root, shawshank.title)).to be_nil
      expect(root.right.left).to be_nil
      expect(root.right.right).to be_nil
    end
  end

  describe "#printf" do
     specify {
       expected_output = "Pacific Rim: 72\nBraveheart: 78\nStar Wars: Return of the Jedi: 80\nThe Matrix: 87\nDistrict 9: 90\nStar Wars: The Empire Strikes Back: 94\nInception: 86\nStar Wars: A New Hope: 93\nThe Shawshank Redemption: 91\nThe Martian: 92\nMad Max 2: The Road Warrior: 98\n"
       tree.insert(hope)
       tree.insert(empire)
       tree.insert(jedi)
       tree.insert(martian)
       tree.insert(pacific_rim)
       tree.insert(inception)
       tree.insert(braveheart)
       tree.insert(shawshank)
       tree.insert(district)
       tree.insert(mad_max_2)
       expect { tree.printf }.to output(expected_output).to_stdout
     }

     specify {
       expected_output = "Pacific Rim: 72\nStar Wars: Return of the Jedi: 80\nBraveheart: 78\nThe Matrix: 87\nThe Shawshank Redemption: 91\nDistrict 9: 90\nInception: 86\nMad Max 2: The Road Warrior: 98\nThe Martian: 92\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\n"
       tree.insert(mad_max_2)
       tree.insert(district)
       tree.insert(shawshank)
       tree.insert(braveheart)
       tree.insert(inception)
       tree.insert(pacific_rim)
       tree.insert(martian)
       tree.insert(jedi)
       tree.insert(empire)
       tree.insert(hope)
       expect { tree.printf }.to output(expected_output).to_stdout
     }
  end
end
