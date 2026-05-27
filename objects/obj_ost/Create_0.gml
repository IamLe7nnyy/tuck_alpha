//OST PLAYLIST

//SOUND
water_sound = audio_play_sound(snd_water, 1, true);
music_sound = audio_play_sound(snd_french_letter, 1, true);

// --- SET DEFAULT VOLUME ---
audio_sound_gain(water_sound, 0.0, 0);   // make it 0.15
audio_sound_gain(music_sound, 0.0, 0);   // make it 0.4