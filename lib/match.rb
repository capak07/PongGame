require 
class Match
    attr_accessor :left_score, :right_score, :paused
    
    def initialize
        left_score = 0
        right_score = 0

        @paused = true
    end


    def end
        if left_score > right_score
           

        elsif right_score > left_score
        end
    end
    
end