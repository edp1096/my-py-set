import os
import sys

sys.path.append(os.getcwd())

keywords = {}
keywords["그레이하운드"] = "greyhound"
# keywords["골든리트리버"] = "golden_retriever"
# keywords["닥스훈트"] = "dachshund"
# keywords["리트리버"] = "retriever"
# keywords["말라뮤트"] = "malamute"
# keywords["말티즈"] = "maltese"
# keywords["보더콜리"] = "border_collie"
# keywords["불독"] = "bulldog"
# keywords["비글"] = "beagle"
# keywords["비숑프리제"] = "bichon_frise"
# keywords["비글"] = "beagle"
# keywords["스피츠"] = "siberian_husky"
# keywords["시바견"] = "shiba"
# keywords["시츄"] = "shih_tzu"
# keywords["웰시코기"] = "welsh_corgi"
# keywords["요크셔테리어"] = "yorkshire_terrier"
# keywords["진돗개"] = "jindo"
# keywords["포메라니안"] = "pomeranian"
# keywords["포인터"] = "pointer"
# keywords["푸들"] = "poodle"
# keywords["프렌치불독"] = "french_bulldog"
# keywords["페키니즈"] = "pekingese"
# keywords["허스키"] = "husky"
# keywords["푸들"] = "poodle"
# keywords["치와와"] = "chihuahua"
# keywords["래브라도리트리버"] = "labrador_retriever"

import multiprocessing as mproc
import webdriver, crawler

def worker(keyword, filename_prefix):
    print("Spawn: ", keyword, filename_prefix)
    crawler.crawling_img(keyword, filename_prefix)


procs = []
if __name__ == '__main__':
    webdriver.download()

    for k, f in keywords.items():
        proc = mproc.Process(target=worker, args=(k, f))
        proc.start()
        procs.append(proc)

    for proc in procs:
        proc.join()
