import java.util.Scanner;

/**
 * Name: Mick Zeller
 */
public class Palindrome
    {
    public static void main(String[] args)
        {
        Scanner input = new Scanner(System.in);
        String palindromeCheck;
        while (true)
            {
            System.out.println("Enter a word to see if it is a palindrome!");
            palindromeCheck = input.next().toLowerCase();
            System.out.println("The word " + palindromeCheck + " is a palindrome? " + isPalindromeRecursion(palindromeCheck));
            System.out.println("The word " + palindromeCheck + " is a palindrome? " + isPalindrome(palindromeCheck));
            }
        }

    public static boolean isPalindromeRecursion(String word)
        {
        if (word.length() <= 1)
            {
            return true;
            } else if (word.charAt(0) != word.charAt(word.length() - 1))
            {
            return false;
            } else
            {
            return isPalindromeRecursion(word.substring(1, word.length() - 1)); // creates a new word without the first and last chars and reruns the method
            }
        }

        public static boolean isPalindrome(String word)
            {

                StringBuilder stringBuilder = new StringBuilder(word);
            System.out.println(stringBuilder.toString());
                if(word.equals(stringBuilder.reverse().toString()))
                    {
                        return word.equals(stringBuilder.reverse().toString());
                    }

                    return word.equals(stringBuilder.reverse().toString());

            }
    }
