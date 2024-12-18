from extensions import db

#######################service.py######################
class Service(db.Model):
    __tablename__ = 'services'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    start_command = db.Column(db.String(200), nullable=False)
    stop_condition = db.Column(db.String(200))
    clear_command = db.Column(db.String(200))


#######################robot.py######################
class Robot(db.Model):
    __tablename__ = 'robots'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    init = db.Column(db.Integer, default=2)
    ip = db.Column(db.String, default='127.0.1')
    port = db.Column(db.String, default='9090')
    map_topic = db.Column(db.String, default='map')
    laser_topic = db.Column(db.String, default='scan')
    global_path_topic = db.Column(db.String, default='/plan')
    local_path_topic = db.Column(db.String, default='/local_plan')
    reloc_topic = db.Column(db.String, default='/initialpose')
    nav_goal_topic = db.Column(db.String, default='/goal_pose')
    odometry_topic = db.Column(db.String, default='/wheel/odometry')
    speed_ctrl_topic = db.Column(db.String, default='/cmd_vel')
    battery_topic = db.Column(db.String, default='/battery_status')
    max_vx = db.Column(db.Float, default=0.1)
    max_vy = db.Column(db.Float, default=0.1)
    max_vw = db.Column(db.Float, default=0.3)
    map_frame_name = db.Column(db.String, default='map')
    base_link_frame_name = db.Column(db.String, default='base_link')
    image_port = db.Column(db.String, default='8080')
    image_topic = db.Column(db.String, default='/camera/image_raw')
    image_width = db.Column(db.Float, default=640.0)
    image_height = db.Column(db.Float, default=480.0)

#######################voice.py#####################
class VoiceRecord(db.Model):
    __tablename__ = 'voice_record'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=False)
    voice_filename = db.Column(db.String(255), nullable=False)
    voice_package = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return f'<VoiceRecord {self.name}>'

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'title': self.title,
            'description': self.description,
            'voice_filename': self.voice_filename,
            'voice_package': self.voice_package
        }


#######################waypoint.py#####################
# 种类表
class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    mode = db.Column(db.Integer, nullable=False)  # 1: 配送, 2: 巡逻

    def serialize(self):
        return {"id": self.id, "name": self.name, "mode": self.mode}


# 位置表
class Location(db.Model):
    __tablename__ = 'location'
    id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(db.Integer, db.ForeignKey('category.id'), nullable=False)
    name = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)  # 新增字段

    category = db.relationship('Category', backref=db.backref('locations', lazy=True))

    def serialize(self):
        return {
            "id": self.id,
            "category_id": self.category_id,
            "name": self.name,
            "description": self.description  # 返回 description
        }


# 航点表
class Waypoint(db.Model):
    __tablename__ = 'waypoint'
    
    # Primary key for the waypoint
    id = db.Column(db.Integer, primary_key=True)

    # Foreign key references to Category and Location
    category_id = db.Column(db.Integer, db.ForeignKey('category.id'), nullable=False)
    location_id = db.Column(db.Integer, db.ForeignKey('location.id'), nullable=False)

    # Name of the waypoint
    name = db.Column(db.String(255), nullable=False)
    
    # Description of the waypoint
    description = db.Column(db.Text, default="")
    
    # Random coordinates (if applicable)
    random_coord = db.Column(db.Integer, default=0)
    
    # Fixed coordinates as a string (can be JSON or serialized)
    fixed_coord = db.Column(db.String(255), default="")
    
    # Action to be taken at the waypoint (e.g., triggering an event)
    action = db.Column(db.String(255), default="")
    
    # Parameters related to the action or event
    params = db.Column(db.String(255), default="")

    # Relationship with Category (for reverse lookups)
    category = db.relationship('Category', backref='waypoints')

    # Relationship with Location (for reverse lookups)
    location = db.relationship('Location', backref='waypoints')

    def serialize(self):
        return {
            "id": self.id,
            "category_id": self.category_id,
            "location_id": self.location_id,
            "name": self.name,
            "description": self.description,
            "random_coord": self.random_coord,
            "fixed_coord": self.fixed_coord,
            "action": self.action,
            "params": self.params
        }

