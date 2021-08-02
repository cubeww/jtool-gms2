/*

    --------------------------------------------------------------------------------
    
        Asset : TTE extension - Input
        Author: Cedrik Dubois ( CedSharp )
        
    --------------------------------------------------------------------------------
        
        You are free to do what you want with this asset under
        the following conditions:
            
            1. You cannot sell this asset by itself, but you can sell
               a game that uses this asset.
               ( I tested and will test all input assets on marketplace
                 so if you try to sell it I'll sue you )
               
            2. You cannot take any credit for this asset.
               Common, I spent many days on this asset, I think
               the minimum you can do is respect me with a small
               'Text inputs by cedsharp' somewhere c:
               
            3. You cannot make me responsible for any usage you
               make of this asset. Once you downloaded it, I have
               no liability with it.
               
    --------------------------------------------------------------------------------
    
        ~ How to use ~
        
            
            All you have to do is to create an object and call the following
            scripts in their respective events:
            
                - In 'Create Event', call this script:          tte_ext_input_create
                - In 'Step / Step Event', call this script:     tte_ext_input_step
                - In 'Draw / Draw Event', call this script:     tte_ext_input_draw
                
            That's it!
            You can configure some basic options in the next section.
            
            There is a variable called 'focus' in the input.
            If that variable is true, then the keyboard will be readed by the input.
            If that variable is false, then nothing will happen with the keyboard.
            This is useful if you want to do something else with the keyboard.
            Right now, click outside the textbox fill set focus to false, and clicking
            inside it will set focus back to true, but you can change that variable with code too!
            
            To get or change the text of the input, simply call tte_ext_input_get_text
            or tte_ext_input_set_text from within the input object.

            ex:
            {
                var text;
                with( obj_input ) {
                    text = tte_ext_input_get_text();
                    tte_ext_input_set_text("");
                }
            }
            
            The above piece of code creates a temporary variable, reads the text of an input into it,
            then clears the text of that input. The result is that the variable 'text' now contains the text
            of the input, and the input itself is now empty.
            
            You can also wait for the text to change by calling 'tte_ext_input_set_on_changed'.
            The script you provide will be called each time the text of the input changed.
            To remove your script you can call 'tte_ext_input_clear_on_changed'.
            NOTE: If you set a script while there was already a script, the old script will not be called anymore.
            
            
        ~ Configuring the Input ~

            
            Options can be set after calling 'tte_ext_input_create()'.
            NOTE: They MUST be executed from within the input object.
            
            Here are the options you can change with this input object:
            
                - tte_ext_input_set_multiline( multiline ):
                        Set to true to allow more than one line of text.
                        Set to false for the opposit.
                    
                - tte_ext_input_set_size( width, height ):
                        Change the size of the input. If text is larger, then
                        the input will automatically scroll until the caret is visible.
                    
                - tte_ext_input_set_padding( left, right, top, bottom ):
                        Change the padding of the editor.
                        This option changes the distance from the borders from which to start
                        scrolling from.
                        
                - tte_ext_set_text_color( color, alpha ):
                        Change the color and the alpha of the text inside the input.
                        
                - tte_ext_set_background_color( color, alpha ):
                        Change the background color of the input.
                        
                - tte_ext_set_selection_color( color, alpha ):
                        Change the color of the selection's background ( not the text )
                        
                - tte_ext_set_font( font ):
                        Change the font used for the text in the input.
                        
                - tte_ext_input_set_on_changed( script ):
                        Set the script to bed called each time the input's text changes.
                        
                - tte_ext_input_clear_on_changed():
                        Stop calling the script ( if there is one ) when the input's text changes.
                        
*/