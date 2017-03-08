shared_examples_for :vision_adapter do
  specify '#labels' do
    expect(described_class.instance_method(:labels).arity).to eq(0)
  end

  specify '#faces' do
    expect(described_class.instance_method(:faces).arity).to eq(0)
  end
end
