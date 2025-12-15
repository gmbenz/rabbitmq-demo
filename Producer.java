import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Producer {
    private final static String QUEUE_NAME = "testqueue";

    public static void main(String[] args) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(System.getenv("RABBIT_HOST"));
        factory.setUsername(System.getenv("RABBIT_USER"));
        factory.setPassword(System.getenv("RABBIT_PASS"));

        try (Connection connection = factory.newConnection();
             Channel channel = connection.createChannel()) {

            channel.queueDeclare(QUEUE_NAME, true, false, false, null);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
            for (int i = 1; i <= 10; i++) {
                String timestamp = LocalDateTime.now().format(formatter);
                String message = "Hello message " + i + " at " + timestamp;
                channel.basicPublish("", QUEUE_NAME, null, message.getBytes());
                System.out.println("Sent: " + message);
            }
        }
    }
}
