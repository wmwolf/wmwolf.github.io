import yaml
import json

with open('courses_source.yml') as f:
    courses = yaml.load(f, Loader=yaml.FullLoader)

with open('courses.json', 'w') as f:
    json.dump(courses, f)