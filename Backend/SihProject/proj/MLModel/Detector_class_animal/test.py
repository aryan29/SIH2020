import animal_detector as ad

if __name__ == "__main__":
    obj = ad.AnimalDetector()
    ans = obj.get_number_of_animals('C:\\Users\\Abhilasha\\Pictures\\cow.png')
    print(ans)
    
