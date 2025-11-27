from database import create_connection
from book_managment import book_menu
from member_manager import member_menu
from loan_manager import loan_menu
from statistics_reports import stats_menu

def show_menu():
    print("\\n" + "="*50)
    print("    LIBRARY MANAGEMENT SYSTEM")
    print("="*50)
    print("1. Book Management")
    print("2. Member Management")
    print("3. Loan Management")
    print("4. Statistics & Reports")
    print("0. Exit")
    print("-"*50)

def main():
    while True:
        show_menu()
        choice = input("Select an option (0-3) ").strip()

        if choice == '0':
            print('Closing')
            break
        elif choice == '1':
            book_menu()
        elif choice == '2':
            member_menu()
        elif choice == '3':
            loan_menu()
        elif choice == '4':
            stats_menu()
        else:
            print('Invalid input. Try again.')


if __name__ == '__main__':
    conn = create_connection()
    main()



