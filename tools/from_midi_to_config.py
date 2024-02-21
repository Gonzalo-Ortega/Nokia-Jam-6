#!/usr/bin/env python3

import argparse
import os
import sys
import yaml
import mido

#### SCRIPT TO CONVERT MIDI FILES TO CONFIG FILES ####

# As imput, this script takes a MIDI file and a configuration file. 
# The MIDI file is converted to a list of tracks with their respective notes and durations.

# The output is a configuration yaml file with the following structure:
# - tracks:
#   - name: track_name
#     notes:
#       - [note, time, duration]
#       - [note, time, duration]
#       ...
#     ...


# Function to convert a MIDI file to a list of tracks with their respective notes and durations

def midi_to_config(midi_file, config_file):

    # Read a MIDI file
    mid = mido.MidiFile(midi_file)

    processed_tracks = []

    # Iterate over the MIDI file tracks
    for i, track in enumerate(mid.tracks):
        processed_track = []
        notes_status = {}

        # Iterate over the MIDI file messages
        for msg in track:
        # if msg does not have a time attribute, it is a meta message
            if not hasattr(msg, 'time'):
                continue
            if msg.type == 'note_on':
                notes_status[msg.note] = msg.time
            elif msg.type == 'note_off' and msg.note in notes_status:
                processed_track.append([
                    msg.note,
                    notes_status[msg.note],
                    msg.time-notes_status[msg.note]
                ])
                del notes_status[msg.note]
        processed_tracks.append(
            {
                "name": track.name,
                "notes": processed_track
            }
        )
    # Write the processed tracks to a configuration file
    with open(config_file, 'w') as f:
        yaml.dump(processed_tracks, f)

# Parse the input arguments
def parse_args():
    parser = argparse.ArgumentParser(description='Convert a MIDI file to a configuration file')
    parser.add_argument('midi_file', type=str, help='MIDI file to convert')
    parser.add_argument('config_file', type=str, help='Configuration file to write')
    args = parser.parse_args()
    return args.midi_file, args.config_file

# Main function
def main():

    # Parse the input arguments
    midi_file, config_file = parse_args()

    # Convert the MIDI file to a configuration file
    midi_to_config(midi_file, config_file)

if __name__ == "__main__":
    main()
