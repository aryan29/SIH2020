import tensorflow as tf
import cv2 as cv


class AnimalDetector():
    def get_number_of_animals(self, path_to_image):
        with tf.gfile.FastGFile('/home/aryan/Documents/newsih2020/sih2020/ML Project/Detector_class_animal/frozen_inference_graph.pb', 'rb') as f:
            graph_def = tf.GraphDef()
            graph_def.ParseFromString(f.read())

        with tf.Session() as sess:
            # Restore session
            sess.graph.as_default()
            tf.import_graph_def(graph_def, name='')

            img = cv.imread(path_to_image)
            inp = cv.resize(img, (300, 300))
            inp = inp[:, :, [2, 1, 0]]

            # Run the model
            out = sess.run([sess.graph.get_tensor_by_name('num_detections:0'),
                            sess.graph.get_tensor_by_name(
                                'detection_scores:0'),
                            sess.graph.get_tensor_by_name('detection_boxes:0'),
                            sess.graph.get_tensor_by_name('detection_classes:0')],
                           feed_dict={'image_tensor:0': inp.reshape(1, inp.shape[0], inp.shape[1], 3)})

            num_detections = int(out[0][0])
            dog_count = 0
            sheep_count = 0
            cow_count = 0

            for i in range(num_detections):
                classId = int(out[3][0][i])
                score = float(out[1][0][i])

                if score > 0.3:
                    if (classId == 18):
                        dog_count += 1
                    if (classId == 20):
                        sheep_count += 1
                    if (classId == 21):
                        cow_count += 1
            return dog_count+sheep_count+cow_count


# x=AnimalDetector().get_number_of_animals(
#     "/home/aryan/Documents/newsih2020/sih2020/Backend/SihProject/check2.jpg")
# print(x)