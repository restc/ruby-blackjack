###    BLACKJACK GRAPHICS    ###
#
# => Graphics for Blackjack
# ASCII art
# Banner for game
#
#
#

class Blackjack::Graphics

    class << self

  def blackjack_banner
    clear_screen
    
    puts "\n\n"                                                                                       
    puts "              $$$$$                                  @@@@@@@   @@@@@@@       "        
    puts "             $$$$$$$                                @@@@@@@@@ @@@@@@@@@      "       
    puts "             $$$$$$$                                @@@@@@@@@@@@@@@@@@@      "      
    puts "              $$$$$                                  @@@@@@@@@@@@@@@@@       "    
    puts "        $$$$$ $$$$$ $$$$$                              @@@@@@@@@@@@@         "    
    puts "       $$$$$$$$$$$$$$$$$$$                               @@@@@@@@@           "     
    puts "       $$$$$$$$$$$$$$$$$$$                                @@@@@@@            " 
    puts "        $$$$$   $   $$$$$                                   @@@              "          
    puts "               $$$                                           @               "      
    puts "                                                                             "     
    puts "                                   BLACKJACK                                 "     
    puts "                                                                             "     
    puts "                                                                             "     
    puts "               @@                                            @               "              
    puts "              @@@@                                          @@@              "              
    puts "             @@@@@@                                       @@@@@@@            "              
    puts "            @@@@@@@@                                    @@@@@@@@@@@          "              
    puts "           @@@@@@@@@@                                 @@@@@@@@@@@@@@@        "              
    puts "            @@@@@@@@                                 @@@@@@@@@@@@@@@@@       "               
    puts "             @@@@@@                                   @@@@@@@@@@@@@@@        "                
    puts "              @@@@                                          @@@              "                 
    puts "               @@                                         @@@@@@@            "  
    puts "                                                                             "
           
    sleep(1)
  end

  def short_blackjack_banner
    puts     "******************    BLACKJACK    ******************"
  end

  def clear_screen
    puts `clear`
  end

  def empty_paragraph
    puts "                       "
    puts "                       "
    puts "                       "
    puts "                       "
  end

  def heart
    puts "   @@@@@@@   @@@@@@@   "
    puts "  @@@@@@@@@ @@@@@@@@@  "
    puts "  @@@@@@@@@@@@@@@@@@@  "
    puts "   @@@@@@@@@@@@@@@@@   "
    puts "     @@@@@@@@@@@@@     "
    puts "       @@@@@@@@@       "
    puts "        @@@@@@@        "
    puts "          @@@          " 
    puts "           @           "
  end 

  def diamond
    puts "          @@           "
    puts "         @@@@          "
    puts "        @@@@@@         "
    puts "       @@@@@@@@        "
    puts "      @@@@@@@@@@       "
    puts "       @@@@@@@@        "
    puts "        @@@@@@         "
    puts "         @@@@          "
    puts "          @@           "
  end

  def club
    puts "         $$$$$         " 
    puts "        $$$$$$$        " 
    puts "        $$$$$$$        " 
    puts "         $$$$$         " 
    puts "   $$$$$ $$$$$ $$$$$   " 
    puts "  $$$$$$$$$$$$$$$$$$$  " 
    puts "  $$$$$$$$$$$$$$$$$$$  " 
    puts "   $$$$$   $   $$$$$   "
    puts "          $$$          "                           
  end

  def spade
    puts "           @           "
    puts "          @@@          "
    puts "        @@@@@@@        "
    puts "      @@@@@@@@@@@      "
    puts "    @@@@@@@@@@@@@@@    "
    puts "   @@@@@@@@@@@@@@@@@   "
    puts "    @@@@@@@@@@@@@@@    "
    puts "          @@@          "
    puts "        @@@@@@@        "
  end

end
###    BLACKJACK GRAPHICS    ###