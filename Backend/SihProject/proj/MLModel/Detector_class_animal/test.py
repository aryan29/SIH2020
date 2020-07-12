import animal_detector as ad

if __name__ == "__main__":
    obj = ad.AnimalDetector()
    print('/home/aryan/Downloads/downloads2.webp')
    ans = obj.get_number_of_animals('/home/aryan/Downloads/download1.jpeg')
    print(ans)
