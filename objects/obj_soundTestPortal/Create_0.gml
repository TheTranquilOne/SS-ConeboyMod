var level_array, i, j, check;

event_inherited();
secretActivated = true;
ini_open(global.SaveFileName);
level_array = ["entryway", "steamy", "mineshaft", "molasses"];

for (i = 0; i < array_length(level_array); i++)
{
    for (j = 0; j < 3; j++)
    {
        check = ini_read_real("Secret", level_array[i] + string(j + 1), 0) ? true : false;
        
        if (!check)
        {
            secretActivated = false;
            break;
        }
    }
}

if (ini_read_string("Game", "Judgment", "none") == "none")
    secretActivated = false;

ini_close();