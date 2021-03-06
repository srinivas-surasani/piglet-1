module Piglet
  module Relation
    class Sample # :nodoc:
      include Relation
    
      def initialize(relation, n)
        @sources, @n = [relation], n
      end
    
      def to_s
        "SAMPLE #{@sources.first.alias} #{@n}"
      end
    end
  end
end