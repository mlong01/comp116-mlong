import shodan
import sys

def init():
    API_KEY = raw_input("Please enter API key: ")

    api = shodan.Shodan(API_KEY)
        
    try:
        info = api.info()
    except:
        print("Invalid API key")
        exit()

    print "Query credits: %s" % info['query_credits']
    print "Scan credits: %s" % info['scan_credits']
    
    result = main(api, None)

    while True:
        result = main(api, result)



def main(api, command):
    if not command:
        command = raw_input("What would you like do to?\n" +
                            "'s' -> search\n" +
                            "'i' -> info about Shodan\n" +
                            "'q' -> quit\n\n" + 
                            "Enter: ")

    if command == 's':
        again = search(api)

    elif command == 'i':
        again = info(api)
    
    elif command == 'q':
        exit()
    
    else:
        print("Command not recognized.\n")
        return None

    return again



def search(api):
   return None


def info(api):
    command = raw_input("What would you like to learn more about?\n" +
                        "'p' -> ports Shodan crawls\n" +
                        "'r' -> protocols Shodan scanning API supports\n" +
                        "'s' -> services Shodan crawls\n" +
                        "'i' -> info about your API key\n" +
                        "'b' -> back to main menu\n" +
                        "'q' -> quit\n\n" +
                        "Enter: ")

    if command == 'p':
        p = api.ports()
        for i in p:
            print i
        #todo: implement option to search for a specific port

    elif command == 'r':
        r = api.protocols()
        for prot, desc in r.items():
            print(prot + ": " + desc + "\n")
        #todo: implement option to search specific protocol
    
    elif command == 's':
        s = api.services()
        for serv, desc in s.items():
            print(serv + ": " + desc + "\n")
        #todo: implement option to search specific service
    
    elif command == 'i':
        i = api.info()
        for stat, val in i.items():
            print(stat + ": " + str(val))
        #todo: add descriptions for what each val means
    
    elif command == 'b':
        return None
    
    elif command == 'q':
        exit()
    
    else:
        print("Command not recognized.\n")
        return 'i'


    again = raw_input("Press 'i' to search info again or " + 
                     "any other key to return to the main menu\n\n" +
                     "Enter: ")

    if again == 'i':
        return again
    else:
        return None

        
init()
