"""
Usage:
    python change_line_value.py config/simu.conf.boom2  test_simu.conf.boom2 88 -l 393 -n busWidth
"""

def make_change(input_path, output_path, value, line_number=None, name=None):

  with open(input_path) as f:
    lines = f.readlines()

  assert not (line_number is None or name is None)

  line_number -= 1

  line_name, current_val = lines[line_number].split('=')
  assert line_name.strip() == name.strip()

  lines[line_number] = lines[line_number].replace(current_val.strip(), value)

  with open(output_path, 'w+') as f:
    f.writelines(lines)


if __name__ == '__main__':
    import argparse
    args = argparse.ArgumentParser()
    args.add_argument("input_path", help="input file path")
    args.add_argument("output_path", help="output file path")
    args.add_argument("value", help="new value")
    args.add_argument('-l', "--line_number", type=int, default=None,
                      help="line number of item to change to given `value`")
    args.add_argument('-n', '--name', default=None, 
                      help='Name of item to change (only used as check).')
    args = args.parse_args()

    make_change(input_path=args.input_path,
                output_path=args.output_path,
                value=args.value,
                line_number=args.line_number,
                name=args.name)
