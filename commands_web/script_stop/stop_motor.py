import rclpy
from rclpy.node import Node
from std_srvs.srv import Empty

class StopMotorClient(Node):
    def __init__(self):
        super().__init__('stop_motor_client')
        self.client = self.create_client(Empty, '/stop_motor')
        
        # 等待服务可用
        while not self.client.wait_for_service(timeout_sec=1.0):
            self.get_logger().info('Service not available, waiting again...')
        
        # 创建请求并调用服务
        self.request = Empty.Request()

    def call_service(self):
        self.future = self.client.call_async(self.request)
        rclpy.spin_until_future_complete(self, self.future)
        if self.future.result() is not None:
            self.get_logger().info('Motor stopped successfully!')
        else:
            self.get_logger().error('Failed to call stop_motor service.')

def main(args=None):
    rclpy.init(args=args)
    stop_motor_client = StopMotorClient()
    stop_motor_client.call_service()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
